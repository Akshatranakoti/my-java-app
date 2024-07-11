# Use a base image with Maven and JDK
FROM maven:3.8.4-openjdk-11-slim AS build

# Set the working directory
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package

# Use a smaller JRE base image for the final application
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the Maven build stage to the JRE image
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar ./app.jar

# Specify the command to run the application
CMD ["java", "-jar", "app.jar"]
