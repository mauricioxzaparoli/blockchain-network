TWOORGSCHANNEL_TX=/opt/gopath/src/github.com/hyperledger/fabric/peer/scripts/channel-artifacts/tworgschannel.tx
ORG1ANCHORPEER=/opt/gopath/src/github.com/hyperledger/fabric/peer/scripts/channel-artifacts/Org1MSPanchors.tx
ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

microk8s.kubectl exec cliorg1 -- peer channel create \
    -c tworgschannel -o orderer:7050 -f $TWOORGSCHANNEL_TX --tls \
    --cafile $ORDERER_CA --outputBlock tworgschannel.block

microk8s.kubectl exec cliorg1 -- peer channel update \
    -c tworgschannel -o orderer:7050 -f $ORG1ANCHORPEER --tls --cafile $ORDERER_CA

microk8s.kubectl exec cliorg1 -- peer channel join \
    -o orderer:7050 -b tworgschannel.block --tls --cafile $ORDERER_CA

microk8s.kubectl exec cliorg1 -- env CORE_PEER_ADDRESS=peer1org1:7051; \
    peer channel join \
    -o orderer:7050 -b tworgschannel.block --tls --cafile $ORDERER_CA