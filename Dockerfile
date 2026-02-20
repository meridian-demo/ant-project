FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY build/ /app/
ENTRYPOINT ["java", "-cp", "/app", "Hello"]
