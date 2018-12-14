defmodule Blockcreate do

  defstruct [:number, :data, :nonce, :timestamp, :prev_hash, :hash]     #Block structure defining

  def new(data, number, prev_hash) do
    %Blockcreate{
      data: data,                                                         #Creation of a block with attribues data,number,timestamp
      number: number,
      prev_hash: prev_hash,
      timestamp: NaiveDateTime.utc_now,
    }
  end

  def gensis do
    %Blockcreate{
      number: 0,                                                            #Gensis block creation with no data and prev hash as 0
      data: ["zero_data"],
      prev_hash: "0",
      timestamp: NaiveDateTime.utc_now,
    }
  end

  def valid?(%Blockcreate{} = block) do
    Hashing.hash1(block)==block.hash
  end

  def valid?(%Blockcreate{} = block, %Blockcreate{} = prev_block) do
    (block.prev_hash == prev_block.hash) && valid?(block)
  end


end
