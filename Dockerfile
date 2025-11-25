# --- Stage 1: Builder ---

FROM gradle:jdk17 AS builder

WORKDIR /app

COPY  . .

# Grant execution permissions to the gradlew wrapper script.
RUN chmod +x gradlew

# Converts gradlew from CRLF → LF
RUN apt-get update && apt-get install -y dos2unix && dos2unix gradlew

# Build the Gradle project
RUN ./gradlew clean launchers:simple-connector:build

# --- Stage 2: Runtime ---

FROM eclipse-temurin:17-jre-alpine AS runtime

WORKDIR /opt/app

COPY --from=builder /app/launchers/simple-connector/build/libs/simple-connector.jar ./app.jar

COPY --from=builder /app/launchers/simple-connector/resources/ ./launchers/simple-connector/resources/

EXPOSE 19191
EXPOSE 19193
EXPOSE 19194
EXPOSE 19291
EXPOSE 19192
EXPOSE 19195

ENTRYPOINT ["java", "-Dedc.fs.config=launchers/simple-connector/resources/configuration/provider-configuration.properties", "-jar", "app.jar"]