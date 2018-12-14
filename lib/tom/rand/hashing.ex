defmodule Hashing do
  #@hashattributes [:number, :data, :nonce, :timestamp, :prev_hash]

  def hash(%{} = block) do
    [n,b]=Gen.generatenonce("#{block.data}#{block.number}#{block.prev_hash}#{block.timestamp}")   #Calculating the hash of block and getting nonce and hash
    [n,b]
  end

  def puthash(%{} = block) do
    [m,n]=hash(block)           
                                   
    %{block | hash: n,nonce: m} 
    #IO.inspect(block)                                 #appending hash and nonce to block
  end
  def hash1(%{} = block) do
    :crypto.hash(:sha256,"#{block.data}#{block.number}#{block.prev_hash}#{block.timestamp}#{block.nonce}")|>Base.encode16
  end
  def sha256(binary) do
    :crypto.hash(:sha256, binary) |> Base.encode16
  end
end
