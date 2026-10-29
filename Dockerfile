# ===============================
# STAGE 1: BUILD
# ===============================

FROM maven:3.9-eclipse-temurin-25 AS build

WORKDIR /app

# Parent POM
COPY pom.xml .

# Backend module
COPY wor-portal-app-backend ./wor-portal-app-backend

# Build backend
RUN mvn clean package -pl wor-portal-app-backend -am -DskipTests


# ===============================
# STAGE 2: RUN
# ===============================

FROM eclipse-temurin:25-jre

WORKDIR /app

# Copy Spring Boot JAR
COPY --from=build /app/wor-portal-app-backend/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]