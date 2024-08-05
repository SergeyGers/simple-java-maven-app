# Stage 1: Build the application
FROM maven:3.8.8-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/my-app-1.0.0.jar /app/my-app.jar
ENTRYPOINT ["java", "-jar", "/app/my-app.jar"]
