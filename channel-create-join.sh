TWOORGSCHANNELTX=/home/mauricio/Downloads/blockchain/Kubernetes/blockchain-network/config/

microk8s.kubectl exec  peer channel create \
    -c tworgschannel -o orderer:7050 -f $TWOORGSCHANNELTX