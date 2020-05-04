docker build -t petecarlson/multi-client:latest -t petecarlson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t petecarlson/multi-server:latest -t petecarlson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t petecarlson/multi-worker:latest -t petecarlson/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push petecarlson/multi-client:latest
docker push petecarlson/multi-server:latest
docker push petecarlson/multi-worker:latest

docker push petecarlson/multi-client:$SHA
docker push petecarlson/multi-server:$SHA
docker push petecarlson/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=petecarlson/multi-server:$SHA
kubectl set image deployments/client-deployment client=petecarlson/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=petecarlson/multi-worker:$SHA