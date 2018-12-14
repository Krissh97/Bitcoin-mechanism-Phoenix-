defmodule Bitcoin do
  #def main(args) do
   # args
   # |> parse                            #Calling the parse function
  #end

    
  def parsi(attrs) do
    #n=attrs["users"]
   # {n, ""} = Integer.parse(attrs["users"])
   n=elem(Integer.parse(attrs["users"]), 0)
   z=elem(Integer.parse(attrs["transactions"]), 0)
   # n=attrs["users"]
    IO.inspect(n)
    nodelist = startnodes(n, [])               #calling the start nodes function and storing all the process in nodelist
    IO.inspect(nodelist)
    k=round(0.2*n)  
    miners=createminers(nodelist,k,[])          #Creating miners from the nodelist by choosing from available
   # IO.inspect(miners)
    nodelist1=[]                                #Creating an empty nodelist1
    m = Enum.count(nodelist)
    Gen.broadcast(nodelist,m)                    #Broadcasting intial amount of 100 coins to each node
    count=0
    chain=Blockchain.new  
   # IO.inspect(chain)                                   #Creating Gensis block with zero data
    chain=Gen.transaction(nodelist,z,nodelist1,miners,chain)       #Calling the transactions function to make transactions among the nodes
    chain
    #Enum.each(nodelist, fn(x) ->
     # msg = Gen.messages_received(x)
     # IO.inspect msg
    #end)
    #z=String.to_integer(attrs["transactions"])
    #funloop(1)
  end

  def funloop(1) do
    funloop(1)
  end

  def createminers(nodelist,0,g) do                           #miners creation when K value is zero
    g
  end

  def createminers(nodelist,k,g) do                               #Miners creation for other cases
    g= if k>0 do
     # IO.inspect(Enum.random(nodelist))
      createminers(nodelist,k-1,g++[Enum.random(nodelist)]) 
    end
    g
  end
  
  def startnodes(0, nodelist) do                                    
    nodelist
  end

  def startnodes(n, nodelist) do
    nodelist = if n>0 do
      
      {:ok, pid} = GenServer.start_link(Gen,:broad,[])           #starting the requested number of node      #Calling the start link function
      startnodes(n-1, nodelist++[pid])
    end
    nodelist
  end

end
