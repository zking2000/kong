```
kubectl apply -f cert-manager.yaml
kubectl create ns kong
kubectl apply -f self-signed.yaml
kubectl apply -f pg.yaml
kubectl apply -f kong-cp.yaml
kubectl apply -f kong-dp.yaml
<<<<<<< HEAD
=======
kubectl apply -f kongplugin.yaml
kubectl apply -f kongingress.yaml


options:
curl -X POST --url http://20.253.171.186:8001/services/ --data 'name=web' --data 'url=http://nginx.default.svc.cluster.local' | jq .

curl -i -X POST --url http://52.152.26.188:8001/services/web/routes --data 'paths[]=/web' | jq .
>>>>>>> refs/remotes/origin/main
```

#### 如果不涉及到分流或负载均衡  则不用创建upstream 而只需要一个service和route
```
curl -X POST --url http://34.29.209.21:8001/services/ --data 'name=web' --data 'url=http://nginx.default.svc.cluster.local' | jq .

curl -i -X POST --url http://34.29.209.21:8001/services/web/routes --data 'paths[]=/web' | jq .
```


#### 创建一个转发到baidu
```
curl -X POST --url http://$admin_url:8001/services/ --data 'name=baidu' --data 'url=https://www.google.com' | jq .

curl -X POST --url http://$admin_url:8001/services/baidu/routes --data 'paths[]=/baidu' | jq .
```

#### 创建一个upstream以及两个targets分别指向两个后端服务。创建一个service和route 流量将会在这两个target之间轮训

```
curl -X POST http://34.29.209.21:8001/upstreams --data "name=nginx-upstream"

curl -X POST http://34.29.209.21:8001/upstreams/nginx-upstream/targets --data "target=nginx.default.svc.cluster.local:80" --data "weight=100"
curl -X POST http://34.29.209.21:8001/upstreams/nginx-upstream/targets --data "target=httpd.default.svc.cluster.local:80" --data "weight=100"

curl -X POST http://34.29.209.21:8001/services --data "name=nginx-service" --data "host=nginx-upstream"

curl -X POST http://34.29.209.21:8001/services/nginx-service/routes --data "paths[]=/nginx"

```