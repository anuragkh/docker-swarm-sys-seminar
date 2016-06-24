DOCKER_HOST=$(docker-machine ip manager):3376

# Get information about the swarm
echo "============= Swarm Info ============="
docker info

# Run a container on the swarm
echo "============= Running hello world container on Swarm ============="
docker run hello-world

# Check to see which node the container ran on
echo "============= Containers and which nodes they ran on ============="
docker ps -a

