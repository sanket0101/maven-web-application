############################
# Stage 1 - Build
############################
FROM maven:3.9.9-eclipse-temurin-11 AS builder

WORKDIR /app

# Copy pom first for dependency caching
COPY pom.xml .

RUN mvn dependency:go-offline

# Copy source code from repo
COPY src ./src

# Build WAR
RUN mvn clean package -DskipTests

############################
# Stage 2 - Runtime
############################
FROM tomcat:9.0-jdk11-temurin

# Create non-root user
RUN groupadd -r tomcatgrp && \
    useradd -r -g tomcatgrp -d /usr/local/tomcat tomcatusr

# Remove default applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR from build stage
COPY --from=builder \
    /app/target/maven-web-application.war \
    /usr/local/tomcat/webapps/ROOT.war

# Set ownership
RUN chown -R tomcatusr:tomcatgrp /usr/local/tomcat

USER tomcatusr

EXPOSE 8080

CMD ["catalina.sh", "run"]
