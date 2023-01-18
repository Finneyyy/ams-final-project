# Credit: https://www.docker.com/blog/containerizing-a-legendary-petclinic-app-built-with-spring-boot/

FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./

RUN ./mvnw dependency:resolve

COPY src ./src

CMD ["./mvnw","spring-boot:run"]
