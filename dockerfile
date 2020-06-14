FROM maven:3.5.2-jdk-8-alpine AS MAVEN_BUILD
MAINTAINER Code Tube
COPY pom.xml /build/
COPY src /build/src/
WORKDIR /build/
RUN mvn clean package
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=MAVEN_BUILD /build/target/docker-boot-ecs-0.0.1.jar /app/
ENTRYPOINT ["java", "-jar", "docker-boot-ecs-0.0.1.jar"]