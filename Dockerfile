# Stage 1: Build with Java 11
FROM maven:3.9.6-eclipse-temurin-11 as builder

WORKDIR /app

# Add Jenkins repo settings
COPY settings.xml /root/.m2/settings.xml

# Copy plugin source
COPY . .

# Clean install
RUN mvn clean install -DskipTests -U

# Stage 2: Keep only the .hpi file
FROM eclipse-temurin:11-jre

WORKDIR /plugin
COPY --from=builder /app/target/*.hpi .

CMD ["ls", "-l", "/plugin"]
