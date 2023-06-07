HELPER=$$(docker ps -a -q)
FOLDER=$(shell pwd)

build:
	docker build -t myserver:v1.0 .

run:
	docker run --name mycontainer -d -p 80:81 -v $(FOLDER)/nginx/nginx.conf:/etc/nginx/nginx.conf myserver:v1.0

clean:
	docker stop $(HELPER)
	docker rm $(HELPER)