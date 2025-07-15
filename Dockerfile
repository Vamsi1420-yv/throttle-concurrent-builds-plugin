# Stage 1: Build the plugin
FROM maven:3.9.6-eclipse-temurin-8 AS builder

WORKDIR /app

# Add Jenkins repositories config
COPY settings.xml /root/.m2/settings.xml

# Copy the source code
COPY . .

# Force Maven to re-download dependencies and skip tests
RUN mvn clean install -DskipTests -U

# Stage 2: Optional minimal image to hold only the HPI
# (You can use this if deploying elsewhere, otherwise keep using `builder`)
FROM openjdk:8-jdk-alpine

WORKDIR /plugin

# Copy the built plugin from the builder stage
COPY --from=builder /app/target/*.hpi /plugin/

CMD ["ls", "-l", "/plugin"]
