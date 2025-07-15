# Stage 1: Build the Jenkins plugin using Maven and Java 11
FROM maven:3.9.6-eclipse-temurin-11 as builder

WORKDIR /app

# Optional: Use a custom Maven settings file if needed
# COPY settings.xml /root/.m2/settings.xml

# Copy source code into the container
COPY . .

# Skip tests and SpotBugs for faster Docker builds
RUN mvn clean install -DskipTests -Dspotbugs.skip=true -U

# Stage 2: Copy only the HPI (plugin) file to a minimal runtime image
FROM eclipse-temurin:11-jre

WORKDIR /plugin

# Copy the plugin artifact from builder stage
COPY --from=builder /app/target/*.hpi .

# Default command just lists the plugin file
CMD ["ls", "-l", "/plugin"]
