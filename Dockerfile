# Use a lightweight OpenJDK image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the jar file
COPY target/*.jar app.jar

# Download the OpenTelemetry agent JAR during build
ADD https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar opentelemetry-javaagent.jar

# Run the app with the Java agent
ENTRYPOINT ["java", "-javaagent:opentelemetry-javaagent.jar", \
    "-Dotel.service.name=api-tutorial", \
    "-Dotel.exporter.otlp.endpoint=http://tempo.observability.svc:4317", \
    "-Dotel.exporter.otlp.protocol=grpc", \
    "-Dotel.logs.exporter=none", \
    "-Dotel.metrics.exporter=none", \
    "-jar", "app.jar"]

