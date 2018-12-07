export FABRIC_CFG_PATH=$PWD

echo -en "\n\e[34m======================= Start generating crypto materials =======================\e[0m\n"
cryptogen generate --config=crypto-config.yaml --output=../CryptoMaterials/crypto-config
if [ "$?" -ne 0 ]; then
  echo -en "\e[91mFailed to generate crypto material...\e[0m"
  exit 1
else
  echo -en "\e[92m======================= Crypto materials generated Successfully =======================\e[0m\n"
fi

echo -en "\n\e[34m======================= Start generating OrdererGenesis =======================\e[0m\n"
configtxgen -profile OrdererGenesis -channelID ordererchannel -outputBlock ../ConfigTxMaterials/orderer-genesis.block
if [ "$?" -ne 0 ]; then
  echo "\e[91mFailed to generate crypto material...\e[0m"
  exit 1
else
  echo -en "\e[92m======================= OrdererGenesis generated Successfully =======================\e[0m\n"
fi

echo -en "\n\e[34m======================= Start generating GlobalChannel's tx =======================\e[0m\n"
configtxgen -profile GlobalChannel -channelID globalchannel -outputCreateChannelTx ../ConfigTxMaterials/globalchannel.tx
if [ "$?" -ne 0 ]; then
  echo "\e[91mFailed to generate crypto material...\e[0m"
  exit 1
else
  echo -en "\e[92m======================= GlobalChannel's tx generated Successfully =======================\e[0m\n"
fi

echo -en "\e[92mAll DONE !!!\e[0m\n"
