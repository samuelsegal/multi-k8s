docker build -t samuelsegal/multi-client:latest -t samuelsegal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t samuelsegal/multi-server:latest -t samuelsegal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t samuelsegal/multi-worker:latest -t samuelsegal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push samuelsegal/multi-client:latest
docker push samuelsegal/multi-server:latest
docker push samuelsegal/multi-worker:latest

docker push samuelsegal/multi-client:$SHA
docker push samuelsegal/multi-server:$SHA
docker push samuelsegal/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=samuelsegal/multi-server:$SHA
kubectl set image deployments/client-deployment client=samuelsegal/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=samuelsegal/multi-worker:$SHA
