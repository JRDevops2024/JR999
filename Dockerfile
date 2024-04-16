# Use a base image with Java installed
FROM openjdk:11-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Environment variables for MySql details
ENV MYSQL_HOST=your_mysql_host
ENV MYSQL_PORT=your_mysql_port
ENV MYSQL_DATABASE=your_mysql_database
ENV MYSQL_USER=your_mysql_user
ENV MYSQL_PASSWORD=your_mysql_password

# Download the MySql JDBC driver
RUN curl -sL https://dev.mysql.com/get/connector-j/8.0.30/mysql-connector-java-8.0.30.jar -o /app/mysql-connector-java.jar

# Add the JDBC driver to the classpath
COPY --from=builder /app/mysql-connector-java.jar /app/lib/

# Compile the Java source files and create a JAR file
RUN javac -cp /app/lib/mysql-connector-java.jar *.java
RUN jar cfe app.jar Start *.class

# Set the default command to run the application
CMD ["java", "-cp", "/app/lib/mysql-connector-java.jar:app", "Start"]
