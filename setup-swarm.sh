# Create a Swarm Discovery
eval $(docker-machine env manager)
cluster_id=`docker run --rm swarm create`

# Create Swarm manager
docker run -d -p 3376:3376 -t -v /var/lib/boot2docker:/certs:ro swarm manage\
  -H 0.0.0.0:3376 --tlsverify --tlscacert=/certs/ca.pem\
  --tlscert=/certs/server.pem --tlskey=/certs/server-key.pem token://$cluster_id

# Create and advertise swarm agents
# Node 1
eval $(docker-machine env agent1)
docker run -d swarm join --addr=$(docker-machine ip agent1):2376\
  token://$cluster_id

# Node 2
eval $(docker-machine env agent2)
docker run -d swarm join --addr=$(docker-machine ip agent2):2376\
  token://$cluster_id

# Node 3
eval $(docker-machine env agent2)
docker run -d swarm join --addr=$(docker-machine ip agent3):2376\
  token://$cluster_id
