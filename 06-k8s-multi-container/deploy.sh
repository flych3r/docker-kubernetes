docker build -t '<docker-id>/multi-client:latest' '<docker-id>/multi-client:$SHA' -f ./client/Dockerfile ./client
docker build -t '<docker-id>/multi-server:latest' '<docker-id>/multi-server:$SHA' -f ./server/Dockerfile ./server
docker build -t '<docker-id>/multi-worker:latest' '<docker-id>/multi-worker:$SHA' -f ./worker/Dockerfile ./worker

docker push '<docker-id>/multi-client:latest'
docker push '<docker-id>/multi-server:latest'
docker push '<docker-id>/multi-worker:latest'

docker push '<docker-id>/multi-client:$SHA'
docker push '<docker-id>/multi-server:$SHA'
docker push '<docker-id>/multi-worker:$SHA'

kubectl apply -f k8s/

kubectl set image deployments/client-deployment client='<docker-id>/multi-client:$SHA'
kubectl set image deployments/server-deployment server='<docker-id>/multi-server:$SHA'
kubectl set image deployments/worker-deployment worker='<docker-id>/multi-worker:$SHA'
