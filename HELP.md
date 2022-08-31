
docker network create automizer-network

docker stop automizer-be && docker rm -f automizer-be && docker image rm -f automizer && mvn package -Dmaven.test.skip=true && docker build -t automizer . && docker run --privileged -dt -p 8080:8080 --network automizer-network --name automizer-be automizer

docker run --privileged -dt -p 4444:4444 -p 7900:7900 --network automizer-network -e SCREEN_WIDTH=1920 -e SCREEN_HEIGHT=1080 -e SCREEN_DEPTH=24 --link automizer-be --name selenium-grid selenium/standalone-chrome

access 7900 port for display

put all html in resource/template folder
put all js and css in resource/static folder