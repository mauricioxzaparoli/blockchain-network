#   Org1 chaincode id: fabcar:1e4ff6bbecf64ccc6ae6c9a8738827943da69de5b1e165762d9484b6134b1ebd
#   Org2 chaincode id: fabcar:22713a8d18b1e0d90252c918786dfe37afb919dad5ee5b6ee9568e8a170d50eb

ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

microk8s.kubectl exec cliorg1 -- peer lifecycle chaincode \
    install /opt/gopath/src/github.com/chaincode/packing/fabcar-org1.tar.tgz

microk8s.kubectl exec cliorg2 -- peer lifecycle chaincode \
    install /opt/gopath/src/github.com/chaincode/packing/fabcar-org2.tar.tgz

microk8s.kubectl exec cliorg1 -- peer lifecycle chaincode approveformyorg \
    --channelID tworgschannel --name fabcar --version 1.0 --init-required \
    --package-id fabcar:1e4ff6bbecf64ccc6ae6c9a8738827943da69de5b1e165762d9484b6134b1ebd \
    --sequence 1 -o orderer:7050 --tls --cafile $ORDERER_CA

microk8s.kubectl exec cliorg2 -- peer lifecycle chaincode approveformyorg \
    --channelID tworgschannel --name fabcar --version 1.0 --init-required \
    --package-id fabcar:22713a8d18b1e0d90252c918786dfe37afb919dad5ee5b6ee9568e8a170d50eb \
    --sequence 1 -o orderer:7050 --tls --cafile $ORDERER_CA

microk8s.kubectl exec cliorg1 -- peer lifecycle chaincode commit -o orderer:7050 \
    --channelID tworgschannel --name fabcar --version 1.0 --sequence 1 --init-required \
    --tls --cafile $ORDERER_CA --peerAddresses peer0org1:7051 --tlsRootCertFiles \
    /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt --peerAddresses peer0org2:7051 --tlsRootCertFiles \
    /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt