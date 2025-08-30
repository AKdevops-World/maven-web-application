# Use a Maven base image to build the application
FROM maven:3.8-openjdk-17-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the Maven project, skipping tests
RUN mvn clean package -DskipTests

# Use a lean base image to run the application
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage with a specific name
# Replace 'maven-web-application-1.0-SNAPSHOT.jar' with the exact name of your JAR file
# (You can find this name by running 'mvn package' locally)
COPY --from=build /app/target/maven-web-application-1.0-SNAPSHOT.jar app.jar

# Expose the port your application listens on (e.g., 8080)
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]
