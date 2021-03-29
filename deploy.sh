docker build -t ffreitasit/multi-client:latest -t ffreitasit/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ffreitasit/multi-server:latest -t ffreitasit/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ffreitasit/multi-worker:latest -t ffreitasit/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ffreitasit/multi-client:latest
docker push ffreitasit/multi-server:latest
docker push ffreitasit/multi-worker:latest

docker push ffreitasit/multi-client:$SHA
docker push ffreitasit/multi-server:$SHA
docker push ffreitasit/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=ffreitasit/multi-client:$SHA
kubectl set image deployments/server-deployment server=ffreitasit/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ffreitasit/multi-worker:$SHA