#!/bin/bash
echo "Setting up Spring Boot app with Java 8..."

# Install Java 8 and Maven
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk maven

# Set Java 8 as default
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /home/vagrant/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

# Verify Java version
java -version

# Navigate to synced folder
cd /home/vagrant/app

# Update Spring Boot properties to point to Redis & MySQL
cat > src/main/resources/application.properties <<EOF
spring.datasource.url=jdbc:mysql://192.168.56.10:3306/taskdb
spring.datasource.username=taskuser
spring.datasource.password=taskpass

spring.redis.host=192.168.56.11
spring.redis.port=6379

server.port=8080
EOF

# Build and run the app
mvn clean package -DskipTests

# Run the Spring Boot app in the background
nohup java -jar target/*.jar > /home/vagrant/app.log 2>&1 &
