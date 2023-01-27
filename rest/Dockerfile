# Credit: https://www.docker.com/blog/containerizing-a-legendary-petclinic-app-built-with-spring-boot/

# FROM eclipse-temurin:17-jdk-jammy

# WORKDIR /app

# COPY .mvn/ .mvn
# COPY mvnw pom.xml ./

# RUN ./mvnw dependency:resolve

# COPY src ./src

# CMD ["./mvnw","spring-boot:run"]

FROM maven:3.8.4-jdk-8 AS build
COPY . .
RUN mvn clean package

FROM openjdk:8
COPY --from=build /target/rest-2.6.2.jar app.jar
EXPOSE 9966
ENTRYPOINT [ "java", "-jar", "app.jar" ]
