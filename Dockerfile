# Use an official Maven image to build the application
FROM maven:3.8.1-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the project files
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package

# Use an OpenJDK image to run the application
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/my-java-app-1.0-SNAPSHOT.jar /app/my-java-app.jar

# Command to run the application
CMD ["java", "-jar", "/app/my-java-app.jar"]

