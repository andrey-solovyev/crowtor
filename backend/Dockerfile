FROM openjdk:14-jdk-alpine

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} backend-0.0.1.jar

ENTRYPOINT ["java", "-Xms450m","-Xmx500m", "-Dserver.port=8080","-jar","/backend-0.0.1.jar"]
