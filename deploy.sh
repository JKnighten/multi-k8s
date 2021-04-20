docker build -t jknighten/multi-client:latest -t jknighten/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jknighten/multi-server:latest -t jknighten/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jknighten/multi-worker:latest -t jknighten/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push jknighten/multi-client:latest
docker push jknighten/multi-client:$SHA 
docker push jknighten/multi-server:latest
docker push jknighten/multi-server:$SHA 
docker push jknighten/multi-worker:latest
docker push jknighten/multi-worker:$SHA 
kubectl apply -f k8s
kubectl set image deployments/server-deployment api=jknighten/multi-server:$SHA
kubectl set image deployments/client-deployment client=jknighten/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jknighten/multi-worker:$SHA