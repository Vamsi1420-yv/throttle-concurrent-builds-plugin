# Base image with Java 8 and Maven
FROM maven:3.9.6-eclipse-temurin-8

# Set working directory in container
WORKDIR /app

# Copy the plugin source code to the container
COPY . .

# Build the plugin
RUN mvn clean install -DskipTests

# Final image doesn't need to run anything, it's just for build
