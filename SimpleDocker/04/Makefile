# Stores the container IDs of all Docker containers in the HELPER variable
HELPER=$$(docker ps -a -q)
# Stores the current working directory in the FOLDER variable
FOLDER=$(shell pwd)
# Builds a Docker image with the tag "myserver"
build:
	docker build -t myserver .

# Runs a Docker container with the name "mycontainer" on port 80, mapping it to port 81 in the
# container, and mounting the specified configuration file
run:
	docker run --name mycontainer -d -p 80:81 -v $(FOLDER)/nginx/nginx.conf:/etc/nginx/nginx.conf myserver

# Stops all running Docker containers
# Removes all stopped Docker containers
clean:
	docker stop $(HELPER)
	docker rm $(HELPER)
