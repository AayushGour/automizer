# FROM openjdk:11
# RUN mkdir /opt/app
# COPY target/automizer-0.0.1-SNAPSHOT.jar /opt/app
# CMD ["java", "-jar", "/opt/app/automizer-0.0.1-SNAPSHOT.jar"]

FROM maven:3.8.5-openjdk-11 as MAVEN_BUILD
WORKDIR /app
COPY ./ ./
RUN mvn clean package -DskipTests
FROM openjdk:11
WORKDIR /spring
COPY --from=MAVEN_BUILD /app/target/*.jar ./app.jar
CMD ["java", "-jar", "app.jar"]


# docker stop automizer-be
# docker rm -f automizer-be
# docker image rm -f automizer
# mvn package -Dmaven.test.skip=true
# docker build -t automizer .
# docker run -dt -p 8080:8080 --name automizer-be automizer

# docker stop automizer-be && docker rm -f automizer-be && docker image rm -f automizer && mvn package -Dmaven.test.skip=true && docker build -t automizer . && docker run -dt --privileged -p 8080:8080 --name automizer-be automizer
# docker stop automizer-be && docker rm -f automizer-be && docker image rm -f automizer && mvn package -Dmaven.test.skip=true && docker build -t automizer . && docker run --privileged -p 8080:8080 -p 4444:4444 --name automizer-be automizer

# use host networking --network host
# get docker volume and get/set configuration
# use docker deamon -> port forward on TCP -> develop docker api

# FROM maven:3.8.5-openjdk-11 as MAVEN_BUILD
# WORKDIR /app
# COPY ./ ./
# RUN mvn clean package -DskipTests
# FROM openjdk:11
# WORKDIR /spring
# COPY --from=MAVEN_BUILD /app/target/*.jar ./app.jar
# CMD ["java", "-jar", "app.jar"]