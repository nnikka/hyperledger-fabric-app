# Generate the crypto
cryptogen generate --config=crypto-config.yaml --output=crypto-config

# Generate the genesis
configtxgen -profile OrdererGenesis -channelID ordererchannel -outputBlock ./orderer/orderer-genesis.block
export FABRIC_CFG_PATH=$PWD
cd orderer
configtxgen -inspectBlock ./orderer-genesis.block

# Generate the channel tx
configtxgen -outputCreateChannelTx ./org1peer1/channel.tx  -profile Channel -channelID mainhannel
cd org1peer1
configtxgen --inspectChannelCreateTx ./channel.tx


# Run orderer
cd orderer
export FABRIC_CFG_PATH=$PWD
orderer

# Run org1peer1
cd org1peer1
./env.sh

Launch Peer
==========
> peer node start -o localhost:8050

Create the channel using the channel transaction created earlier
================================================================
> peer channel create -o localhost:8050 -c mainhannel -f ./channel.tx

Join the channel
================
> peer channel join -o localhost:8050 -b ./mainhannel.block

List the channels
=================
> peer channel list

fetch
=====
 peer channel fetch 0 mainhannel.block -c mainhannel -o localhost:8050


 # Chain code
==============
 > npm install
 > CORE_CHAINCODE_ID_NAME="mycc:v0" node --inspect mycc.js --peer.address grpc://0.0.0.0:7052
 RESPONSE: configured chaincode (everything fine you will get ‘Successfully established communication with peer node. State transferred to "ready"’ )

 Go to terminal 2
 > peer chaincode install -l node -n mycc -v v0 -p nodefiles(directory name where we have put chaincode files)
 > CORE_PEER_LOCALMSPID="Org1MSP"
 > peer chaincode instantiate -l node -n mycc -v v0 -C mychannel -c '{"args":["init","1","2"]}'
