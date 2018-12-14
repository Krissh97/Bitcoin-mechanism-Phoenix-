defmodule Gen do
  use GenServer

  def init(:broad) do
    pvtkey =  :crypto.strong_rand_bytes(32)                                                             #obtaining the private key of each node
    publickey = :crypto.generate_key(:ecdh, :crypto.ec_curve(:secp256k1), pvtkey) |> elem(0)             #obtaining the public key of each node
    :gproc.reg(gproc_key(:broad))                                                                        #Registring a topic :broad to broadcast
    {:ok, [%{:priv=> pvtkey, :pub=> publickey,:coins=> 0,:block=> []},[]]}
  end
  
  
  def broadcast(nodelist, 0) do end          

  def broadcast(nodelist, m) do
    if m>-1 do
      pid=Enum.at(nodelist,m-1)                       #Getting pid of each created node
      GenServer.cast(pid,{:bitcoins})                 #calling cast to send 100 to each
      :timer.sleep(1)
      broadcast(nodelist, m-1)                        #Recursively calling the function for all the nodes
    end
    :ok
  end

  def handle_cast({:bitcoins},state) do
    [a,l]=state
    n=a.coins
    c=n+100                                           #assigning 100 coins to each node and updating the state
    a=Map.put(a,:coins,c)
    state=[a,l]
    {:noreply,state}
  end

  def messages_received(pid) do
   # IO.inspect("handle call")
    GenServer.call(pid, :messages_received)                                 #Message received  call
  end

  def handle_call(:messages_received, _from, m) do
    messages_received=(Enum.at(m,0)[:block])                              #Handle call for the call made above
    {:reply, messages_received, m}
  end

  def broadcast1(topic, message) do
   # IO.inspect("broadcasting")
    GenServer.cast({:via, :gproc, gproc_key(:broad)}, {:broadcast, message})          #Genserver.cast to broad cast the updated chain to entire network
  end
  
  def transaction(nodelist,-1,nodelist1,miners,chain) do 
   chain
  
  end
  
  def transaction(nodelist,b,nodelist1,miners,chain) do
    if b>-1 do
      x=Enum.random(nodelist)                                                     #picking a sender
      y=Enum.random(nodelist--[x])                                                #picking a receiver
      z=Enum.random(1..50)
      senderamount = getbal(x)                                                      #Checking sender balance before making transaction
      if senderamount > z do
        GenServer.cast(x,{:decrease,z})                                             #updating sender and receiver balances after transaction
        GenServer.cast(y,{:increase,z})
        messagestr = "#{inspect x} sent #{z} amount to #{inspect y}"
        signature = getsignature(messagestr,x)                                          #generating signature for the transaction 
        flag = verify(messagestr, x, signature)                                         #Verifying the transaction before being broadcasted
        if flag do
          nodelist1=nodelist1++["#{inspect x} sent #{z} amount to #{inspect y}"]          #appending transaction to nodelist1 to broadcast to all nodes
          if rem(b-1,10)==0 do                                                            #limiting 10 transactions per block
            data=nodelist1    
            chain1=chain                                             #assigining nodelist1 to data as we put data into block
            chain=Blockchain.putblock(chain,data) 
                                                     #updating the chain with adding new block with 10 new transactions
            findandbroad(chain)                                                           #Broad casting the updated chain to all other nodes
            transaction(nodelist,b-1,[],miners,chain)
          else
            transaction(nodelist,b-1,nodelist1,miners,chain)                              #Recursively calling until the count is equal to 10 to create newblock
          end
        end       
      else
        transaction(nodelist,b,nodelist1,miners,chain)
      end
    else
    # IO.inspect(chain)
    end
  end

  def getsignature(messagestr, x) do
    :crypto.sign(:ecdsa, :sha256, messagestr, [getpvtkey(x), :secp256k1])               #Signature function to get signature
  end

  def getpvtkey(pid) do
    GenServer.call(pid,{:ptkey})                                                    #Call to get privatekey of node used to generate signature
  end

  def handle_call({:ptkey}, _from, state) do
    [a,l] = state
    secretkey = a.priv                                                              #Getting the private key from the state and replying back
    {:reply, secretkey, state}
  end

  def verify(messagestr, x, signature) do
   # IO.inspect(getpubkey(x))
   # IO.inspect( :crypto.verify(:ecdsa, :sha256, messagestr, signature, [getpubkey(x), :secp256k1]))
    :crypto.verify(:ecdsa, :sha256, messagestr, signature, [getpubkey(x), :secp256k1])          #Verifying transaction function
  end

  def getpubkey(pid) do
    GenServer.call(pid,{:pubkey})                                                   #Call to get publickey of node used to verify transaction
  end

  def handle_call({:pubkey}, _from, state) do
    [a,l] = state
    publickey = a.pub                                                               #Getting the publickey of node from state and replying back
    {:reply, publickey, state}
  end

  def getbal(pid) do
    GenServer.call(pid,{:balance})                                                    #Function to get balance of a node 
  end

  def handle_call({:balance}, _from, state) do
    [a,l] = state
    amount = a.coins                                                      #Getting the node balance and replying back to check if has sufficient balance
    {:reply, amount, state}
  end

  def findandbroad(chain) do
    c=Enum.at(chain,0)
    broadcast1(:broad, chain)                                             #Broadcasting the updated chain to all the nodes
    :timer.sleep(10)
  end
  
  def generatenonce(s) do
    f=Enum.random(1..4000000)                                             #random number choosen to find nonce value
    a="#{s}#{f}"
    b=:crypto.hash(:sha256,a)|>Base.encode16
    if String.slice(b, 0..3)=="0000" do                                     #setting the target value to 0000 and generating the nonce value
        [f,b] 
    else  
        generatenonce(s)
    end
  end
  
  def handle_cast({:decrease,z},state) do
    [a,l]=state
    a=Map.put(a,:coins,a[:coins]-z)                                         #Decreasing the sender balance and updating its state
    state=[a,l]
    {:noreply,state}
  end
  
  def handle_cast({:increase,z},state) do
    [a,l]=state
    a=Map.put(a,:coins,a[:coins]+z)                                         #Increasing the receiver balance and updating the state
    state=[a,l]
    {:noreply,state}
  end
  
  def handle_cast({:broadcast, message}, state) do
    [a, l]=state
    a=Map.put(a,:block,message)                                           #handle cast for the broadcast called above
   # IO.inspect(a)
    state=[a,l]
    {:noreply, state}
  end
  
  defp gproc_key(:broad) do                                               #Gproc registing step
    {:p, :l, :broad}
  end

end
