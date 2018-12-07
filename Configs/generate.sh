export FABRIC_CFG_PATH = $PWD

cryptogen generate --config=crypto-config.yaml --output=../CryptoMaterials/crypto-config

configtxgen -profile OrdererGenesis -channelID ordererchannel -outputBlock ../ConfigTxMaterials/orderer-genesis.block

configtxgen -profile GlobalChannel -channelID globalchannel -outputCreateChannelTx ../ConfigTxMaterials/globalchannel.tx
