defmodule BitTest do
  use ExUnit.Case
  doctest Bitcoin

  test "starting the requested number of nodes" do
    assert Bitcoin.startnodes(10,[])
  end

  test "Creating the miners" do
    assert Bitcoin.createminers([1,2,3],2,[])
  end
 
  test "Broadcasting base amount" do
    x = Bitcoin.startnodes(5,[])
    y = Enum.count(x)
    assert Gen.broadcast(x,y)
  end 

  test "Creating a block" do
    assert Blockcreate.new(["data1","data2"], 2, CF4A23E77942AE157A2BA9486C274322F23961CA2753F592383EB5B928FD44751198144752)
  end

  test "gensis block creation" do
    assert Blockcreate.gensis
  end
  
  test "Generate Nonce function" do
    assert Gen.generatenonce("Nonce generation")
  end

  test "Inserting block into chain" do
    x = %Blockcreate{
      data: "x to y 20",                                                         
      number: 5,
      prev_hash: XERTE21286ECD5FB47381555181D8A03F6A80166155C5BBB765A0A053B0DA945,
      timestamp: NaiveDateTime.utc_now,
    }
    assert Blockchain.putblock([x], ["data1","data2"])
  end

  test "Find and broad function" do
    assert Gen.findandbroad([])
  end

  test "Consensus and proof work check" do
    str = "CF4A23E77942AE157A2BA9486C274322F23961CA2753F592383EB5B928FD44751198144752"
    assert String.slice(:crypto.hash(:sha256, str) |> Base.encode16, 0..3)=="0000"
  end

  test "Calculating the Hash of block" do
    x = %Blockcreate{
      data: "x to y 20",                                                         
      number: 5,
      prev_hash: XERTE21286ECD5FB47381555181D8A03F6A80166155C5BBB765A0A053B0DA945,
      timestamp: NaiveDateTime.utc_now,
    }
    assert Hashing.hash(x)
  end

  test "Putting the Hash of block" do
    x = %Blockcreate{
      data: "x to y 20",                                                         
      number: 5,
      prev_hash: XERTE21286ECD5FB47381555181D8A03F6A80166155C5BBB765A0A053B0DA945,
      timestamp: NaiveDateTime.utc_now,
    }
    assert Hashing.puthash(x)
  end

  test "Bakance check function" do
    x = Bitcoin.startnodes(5,[])
    y = Enum.random(x)
    assert Gen.getbal(y)
  end

  
  test "Getting private key of a node" do
    x = Bitcoin.startnodes(5,[])
    y = Enum.random(x)
    assert Gen.getpvtkey(y)
  end

  test "Signature function" do
    x = Bitcoin.startnodes(5,[])
    y = Enum.random(x)
    assert Gen.getsignature("messagestr",y)
  end

  test "Verify  function" do
    x = Bitcoin.startnodes(5,[])
    y = Enum.random(x)
    signature = Gen.getsignature("messagestr",y)
    assert Gen.verify("messagestr", y, signature)
  end

end
