
docker network create automizer-network

docker stop automizer-be && docker rm -f automizer-be && docker image rm -f automizer && mvn package -Dmaven.test.skip=true && docker build -t automizer . && docker run --privileged -dt -p 8080:8080 --network automizer-network --name automizer-be automizer

docker run --privileged -dt -p 4444:4444 -p 7900:7900 --network automizer-network -e SCREEN_WIDTH=1920 -e SCREEN_HEIGHT=1080 -e SCREEN_DEPTH=24 --link automizer-be --name selenium-grid selenium/standalone-chrome

access 7900 port for display

put all html in resource/template folder
put all js and css in resource/static folder

dynamically spawn docker container for selenium grid
dynamically provide IP of selenium grid
dynamically create, delete nodes within the selenium grid


port forward docker unique socket to tcp
docker api v2 endpoint ,make call on tcp created above


Docker compose example
version: "3"
services:
  frontend:
    build: ./project/frontend
    image: frontend:latest
    restart: unless-stopped
    # expose:
    #   - "3000"
    ports:
      - "3000:3000"
  backend:
    build: ./project/backend/
    image: backend:latest
    restart: always
    environment:
      server.port: 8001
      spring.datasource.url: jdbc:postgresql://postgres/stage
      spring.datasource.username: postgres
      spring.datasource.password: postgres
      spring.jpa.database: POSTGRESQL
    expose:
      - "8001"
    depends_on:
      - postgres
    links:
      - postgres # used for making postgres reachable by backend
    # deploy:
    #   mode: replicated
    #   replicas: 3
    # docker-compose --compatibility up
  postgres:
    image: postgres:alpine3.16
    restart: always
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
      POSTGRES_DB: stage
    expose:
      - "5432"