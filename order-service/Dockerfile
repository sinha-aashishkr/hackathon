# Use lightweight JDK runtime
FROM eclipse-temurin:17-jre

# Set working directory
WORKDIR /app

# Copy jar file into container
COPY target/order-service-0.0.1-SNAPSHOT.jar app.jar

# Expose application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]