FROM eclipse-temurin:21-jre-alpine AS runtime

# App home
WORKDIR /app

# Let CI pass the path of the JAR if needed; defaults to Gradle's bootJar output
ARG JAR_FILE=build/libs/*.jar
# Copy the fat (executable) Spring Boot jar
COPY ${JAR_FILE} /app/app.jar

# Container-friendly JVM defaults (tune as needed)
ENV JAVA_OPTS="-XX:MaxRAMPercentage=75 -XX:InitialRAMPercentage=50 -XX:+UseContainerSupport -XX:+AlwaysPreTouch -XX:+UseG1GC"

# OpenShift-friendly permissions: allow arbitrary uid to read/execute
# (OpenShift often runs a random uid; group 0 perms help)
RUN chmod g+rwx /app && chgrp -R 0 /app

EXPOSE 8080
# If you use Spring Boot Actuator, you can later add a HEALTHCHECK to /actuator/health
# HEALTHCHECK --interval=30s --timeout=5s --start-period=30s CMD wget -qO- http://127.0.0.1:8080/actuator/health | grep -q '"status":"UP"' || exit 1

ENTRYPOINT ["sh","-c","exec java $JAVA_OPTS -jar /app/app.jar"]
