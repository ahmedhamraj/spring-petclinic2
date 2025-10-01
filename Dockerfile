FROM openjdk:17-jdk-slim

# Set working directory inside the container
WORKDIR /spring-petclinic

# Copy the jar file into the container
COPY ./target/spring-petclinic-3.5.0-SNAPSHOT.jar spring-petclinic.jar

# Expose the port the application runs on
EXPOSE 8080

# Run the jar
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
