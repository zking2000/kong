```
kubectl apply -f cert-manager.yaml
kubectl apply -f self-signed.yaml
kubectl apply -f pg.yaml
kubectl apply -f kong-cp.yaml
kubectl apply -f kong-dp.yaml

curl -X POST --url http://20.253.171.186:8001/services/ --data 'name=web' --data 'url=http://nginx.default.svc.cluster.local' | jq .

curl -i -X POST --url http://52.152.26.188:8001/services/web/routes --data 'paths[]=/web' | jq .
```
