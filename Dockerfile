# Use a Maven base image to build the application.
FROM maven:3.8-openjdk-17-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the Maven project, skipping tests
RUN mvn clean package -DskipTests

# Use an official Tomcat image to run the web application
FROM tomcat:9-jdk17-temurin-focal

# Copy the .war file from the build stage into Tomcat's webapps directory
COPY --from=build /app/target/maven-web-application.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# The CMD is handled by the Tomcat base image
