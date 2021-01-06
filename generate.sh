export FABRIC_CFG_PATH=${PWD}

rm -fr crypto-config/*
rm -fr config/*

cryptogen generate --config=crypto-config.yaml

configtxgen -profile OrgOrdererGenesis --channelID testchainid -outputBlock ./config/genesis.block

configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./config/tworgschannel.tx -channelID tworgschannel 

configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./config/Org1MSPanchors.tx -channelID tworgschannel -asOrg Org1MSP 

configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./config/Org2MSPanchors.tx -channelID tworgschannel -asOrg Org2MSP
