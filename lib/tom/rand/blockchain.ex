defmodule Blockchain do
  
  def new do
    [Hashing.puthash(Blockcreate.gensis)]                                     #call to create a new gensis block 
  end

  def putblock(blockchain, data) when is_list(blockchain) do
    
    %Blockcreate{number: count, hash: prev} = hd(blockchain)                    #checking if block is valid and adding it to the blockchain
    block = data |> Blockcreate.new(count+1, prev) |> Hashing.puthash
    if Blockcreate.valid?(block) && Blockchain.valid?(blockchain,block) do
      [block | blockchain]
    end
  end

  def valid?(blockchain,block) when is_list(blockchain) do
   # IO.inspect("Valid in blockchain")
    zero = Enum.reduce_while(blockchain, nil, fn prev, current ->                   #Validation of a block chain
      cond do
        current == nil ->
          {:cont, prev}
         
        Blockcreate.valid?(current, prev) ->
          {:cont, prev}

        true ->
          {:halt, false}
      end
    end)
    if zero, do: Blockcreate.valid?(block), else: false
  end
end
