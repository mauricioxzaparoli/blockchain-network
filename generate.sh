export FABRIC_CFG_PATH=${PWD}

rm -fr crypto-config/*
rm -fr config/*

cryptogen generate --config=crypto-config.yaml

configtxgen -profile OrgOrdererGenesis --channelID testchainid -outputBlock ./config/genesis.block

configtxgen -profile CanalHash -outputCreateChannelTx ./config/canalhash.tx -channelID canalhash 

configtxgen -profile CanalHash -outputAnchorPeersUpdate ./config/Org1MSPanchors_CanalHash.tx -channelID canalhash -asOrg Org1MSP 

configtxgen -profile CanalHash -outputAnchorPeersUpdate ./config/Org2MSPanchors_CanalHash.tx -channelID canalhash -asOrg Org2MSP
