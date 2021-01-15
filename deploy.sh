docker build -t dockerhub88/multi-client:latest -t dockerhub88/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dockerhub88/multi-server:latest -t dockerhub88/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dockerhub88/multi-worker:latest -t dockerhub88/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dockerhub88/multi-client:latest
docker push dockerhub88/multi-server:latest
docker push dockerhub88/multi-worker:latest

docker push dockerhub88/multi-client:$SHA
docker push dockerhub88/multi-server:$SHA
docker push dockerhub88/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=dockerhub88/multi-server:$SHA
kubectl set image deployment/client-deployment client=dockerhub88/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=dockerhub88/multi-worker:$SHA 