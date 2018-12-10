docker build -t marlovil/multi-client:latest -t marlovil/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marlovil/multi-server:latest -t marlovil/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marlovil/multi-worker:latest -t marlovil/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marlovil/multi-client:latest
docker push marlovil/multi-server:latest
docker push marlovil/multi-worker:latest
docker push marlovil/multi-client:$SHA
docker push marlovil/multi-server:$SHA
docker push marlovil/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=marlovil/multi-server:$SHA
kubectl set image deployments/client-deployment client=marlovil/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=marlovil/multi-worker:$SHA

