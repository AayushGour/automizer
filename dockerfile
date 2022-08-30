FROM selenium/standalone-chrome
RUN sudo mkdir /opt/app
COPY target/automizer-0.0.1-SNAPSHOT.jar /opt/app
RUN sudo apt-get update
RUN sudo apt-get -y install x11vnc xvfb fluxbox wget wmctrl
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee -a /etc/apt/sources.list.d/google.list
RUN xvfb :99 -screen 0 1920x1080x24 &
RUN export DISPLAY=:1
COPY bootstrap.sh /
CMD [ "./bootstrap.sh" ]
# CMD ["java", "-jar", "/opt/app/automizer-0.0.1-SNAPSHOT.jar"]




# docker stop automizer-be
# docker rm -f automizer-be
# docker image rm -f automizer
# mvn package -Dmaven.test.skip=true
# docker build -t automizer .
# docker run -dt -p 8080:8080 --name automizer-be automizer

# docker stop automizer-be && docker rm -f automizer-be && docker image rm -f automizer && mvn package -Dmaven.test.skip=true && docker build -t automizer . && docker run -dt --privileged -p 8080:8080 --name automizer-be automizer
# docker stop automizer-be && docker rm -f automizer-be && docker image rm -f automizer && mvn package -Dmaven.test.skip=true && docker build -t automizer . && docker run --privileged -p 8080:8080 --name automizer-be automizer

# use host networking --network host
# get docker volume and get/set configuration
# use docker deamon -> port forward on TCP -> develop docker api