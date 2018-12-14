#Team Members:

Krishna Chaitanya Uppala : 3855-8149
Saideep Korrapati        : 9234-8134

#The video of project has been added to the folder with name "final project video".

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

  #Bitcoin Project Phoneix Simulation 4.2



#Phoneix Framework 

We installed the Postgre and set the username and password in the first place. 

#Flow of project with each function explained

Tom - The name of the project to be created

mix phx.new Tom : Creating the project using phoneix Framework
cd Tom          : Redirecting to path of folder

Go to config folder in the Tom folder and go do dev.exs file and update the username and password 

mix ecto.create to create the database

mix phx.gen.html Rand Hall halls users: integer transactions: integer

This command creates a web page which takes input as users and transactions. It also gives a line resources "/halls", HallController that should be added to Router.ex

mix ecto.migrate 

This command creates attributes in database with users and transactions which can further be used to display in webpage.

mix phx.server and in the browser type localhost:4000/halls which opens an web page that takes input users and transactions and once we click save the data is loaded.

and the flow now directs to Hall_controller.ex/create(conn,%{"hall->hall_params"}) in this create_hall(attributes) is called.


Go to Tom/Rand/rand.ex and in the file there is a function Create_hall(attributes) which takes the inputs users and transactions in the form of map

## Create_hall(attributes), we call the Bitcon.Parsi(), In this the attributes are in Bitstring format so these are parsed as integers to function parsi(attributes)

## Function parsi(attribues)

  Arguments passed to this function is  a map, and users are retrived to n from maps and transactions into variable z.  This function is like the main function of project where we create requested number of nodes, createminers, broadcast intial
  amounts to nodes, create the gensis block and make transactions and update the blockchain accordingly calling the respective functions at last we retrive the final chain from this function parsi and flow goes to function parsi(attributes)

## Function startnodes(n, nodelist)

  startnodes is a recursive function which is called to create the requested number of nodes. Startnodes take two arguments n (number of nodes to be started) and nodelist (where pids of nodes are stored). We call the GenServer.start_link method in this function.

## Function init(:broad)

    The start_link of statnodes brings us to this method here we create a private key and public key to each node which are used later for signature and verify. 

## Function createminers(nodelist,k,g)

  createminers is also a recursive function to create a specific number of miner i.e 0.2 times of the total input nodes as miners. argument k is bascially the value of number of miners to be created, nodelist is list of pids, g is the miners list

## Function broadcast(nodelist, m)

  broadcast function takes nodelist, list of pids and m the length of nodelist as arguments. broadcast is a recursive function called for each node, where Genserver.cast is called and state of each node is updated. 

## Function new in module Blockchain

  In this function we creates  gensis block calling the Hashing.puthash(Blockcreate.gensis) and append this to the chain.

## Function putblock(blockchain, data) in module Blockchain

  We call the new function in blockcreate module and create a newblock and update all the block attributes of the block and insert the block at head positon of the list of blockchain. the argument block chain is chain until this operation is called. new block is appended to this block

## Function new(data, number, prev_hash) in module Blockcreate

  This function is used for Creation of a block with attribues data,number,prevhash and timestamp. data here is transactions, number is block number and prev hash is the hash value of the previous block

## Function hash(%{} = block) in module Hashing

  The hash function calls the generatenonce function which returns the nonce value which meets the target hash i.e we get nonce and hash of the block to be appened.

## Function puthash(%{} = block)

  The obtained nonce and hash values using the hash() function are appended to the block. Now our block has all the attributes in it updated when being added into the blockchain

## Function generatenonce(s)

  This function takes an argument string and finds the nonce value such that the target hash value begins with "0000" the function is called recursively until the suitable nonce is found to match the target.

## Function findandbroad(chain)

  The purpose of this function is to broadcast the final updated chain to all the nodes. it calls the broadcast1 function in it which does the broadcast.
  
## Function broadcast1(topic, message)

  This function is called in the findandbroad().  We call the Genserver.cast and broadcast the chain to all nodes listening to a particular topic here we use :gproc dependency. Intially we register the topic and communicate with nodes using the same.

## Function transaction(nodelist,b,nodelist1,miners,chain)

  In this function we make transactions of coins between sender and reveicer. Before sending we check if the sender has valid balance to make transaction if not we ignore the transaction. The balances of the sender and receiver are updated. For a transaction to be added into block we need to verify if the transaction is valid or not. For that we use Signature and verify methods. If the verify method returns true then only we consider it as valid transaction and add it to data in the block. The block size we set is 10 i.e after every 10 transactions a new block is created and transactions are appended to it. This updated blockchain is broadcasted to all the nodes so as every one in the network maintains same chain. 

## Function getpvtkey(pid) 

  This function calls the Genserver.call and returns the private key of the specific node from the state.


## Function getpubkey(pid)

  This function calls the Genserver.call and returns the public key of the specific node from the state.

## Function getbal(pid)

  This function is called to check if the node has sufficient balance to make the transaction or not. if yes then the node can make a transaction if not the transaction is ignored


## Functuion getsignature(messagestr,x)

  It takes messagestr i.e transaction and node as arguments and it is used to get signature using the crypto.sign method using the private key of the node

## Function verify(messagestr, x, signature)

  Verify method uses the crypto.verify function to check if the given transaction is a valid one or not it returns True if the transaction is valid and False if not.
  It uses the public key of the node and signature to verify the transaction

## Function Blockcreate.valid?(%Blockcreate{} = block)
  
  This function validates the block by checking if the hash of given block is valid. When only a block is given it compares the hash value with that of calculated hash value. The block is said to be a valid one only when both values are same.

## Function Blockchain.valid?(Blockchain, block)

  This function goes through the entire block chain in reverse order using the function Enum.reduce validationg the blocks in pairs by checking if the previous hash value in the block is equal to hash of the previous block or not. Even at one point it is false it returns a false value. This helps us to validate the entire Block chain.


After the Pasrsi(attribues) is done execution the next command in the Create_hall(attributes) is

Hall.changeSet(attributes) is called which validates the attributes and then the flow is pipelined to Repo.insert which inserts the given attributes into database

The return value for Create_hall(attributes) is {ok, chain}

Now the function render(conn, "show.html", blocks:blocks)



##Test Cases performed and execution


[1] "Starting requested number of nodes" : Tests the startnodes() function to see if requested number of nodes are created or not.

[2] "Creating the miners" : Tests the createminers() function to see if the expected number of miners are created or not.

[3] "Broadcasting base amount" : Tests the broadcast() function to check if each node receives a base amount of 100 for          transactions.

[4] "Gensis block creation" : Tests the creation of Gensis block i.e the first block of the block chain whose prev hash is 0 and  block number is 0.

[5] "Creating a block" : Tests the Blockcreate.new() function where a new block is created for every 10 transactions.

[6] "Inserting block into chain" : Tests the Blockchain.putblock() function where a created block is added to chain.

[7] "Generate Nonce function" : Tests the Gen.generatenonce() function to get the nonce value for a given input

[8] "Find and broad function" : Tests the Gen.findandbroad() function which broadcasts the chain to all the nodes in the network 
after updating chain.

[9] "Consensus and proof work check" : Tests to see if a given block hash matches the target hash value to begin with four zeroes.

[10] "Calculating the Hash of block" : Tests the calculation of hash for a given block this function returns the obtained hash of block and nonce value

[11] "Putting the Hash of block" : Tests the functionality of insertion of hash and nonce obtained into the block

[12] "Getting private key of a node" : Tests the Gen.getpvtkey() which retruns the privatekey of a particular node in the network

[13] "Balance check function" : Tests the Gen.getbal() which returns the balance amount a node has to make transactions.

[14] "Signature function" : Tests the Gen.getsignature() which generates the signature for a message used to verify transactions

[15] "Verify Function" : Tests the Gen.verify() which verifies if a transaction is valid or not using the signature, publickey and message.

## RESULTS 
After the save button is clicked we are redirected to show.html where our blockchain snd a chart showing the nonce values for the each block is displayed. In the display of block we can see the block number, block data, Nonce and current hash of block


"# Bitcoin-mechanism-Phoenix-" 
