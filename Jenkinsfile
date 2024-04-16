pipeline {
  agent any

  parameters {
    string(defaultValue: '', description: 'MySQL Hostname', name: 'MYSQL_HOST')
    string(defaultValue: '', description: 'MySQL Port', name: 'MYSQL_PORT')
    string(defaultValue: '', description: 'MySQL Database Name', name: 'MYSQL_DATABASE')
    string(defaultValue: '', description: 'MySQL Username', name: 'MYSQL_USER')
    string(defaultValue: '', description: 'MySQL Password', name: 'MYSQL_PASSWORD')
  }

  stages {
    stage('Checkout Source Code') {
      steps {
        // Checkout the source code from your Git repository
        git credentialsId: 'Github-Jenkins', url: 'https://github.com/KrishnaDevops1985/Hotel-Management-System.git', branch: 'master'
      }
    }
    stage('Build Docker Image') {
      steps {
        script {
          // Define the Docker image tag
          def dockerImageTag = "Krishna1234/java-webapp:latest"

          // Pass MySQL details as environment variables during build
          def envVars = [
              "MYSQL_HOST": "${params.MYSQL_HOST}",
              "MYSQL_PORT": "${params.MYSQL_PORT}",
              "MYSQL_DATABASE": "${params.MYSQL_DATABASE}",
              "MYSQL_USER": "${params.MYSQL_USER}",
              "MYSQL_PASSWORD": "${params.MYSQL_PASSWORD}"
          ]

          // Build the Docker image with environment variables
          docker.build(dockerImageTag, '-f Dockerfile .', env: envVars)
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script {
          // Define the Docker image tag
          def dockerImageTag = "Krishna1234/java-webapp:latest"

          // Push the Docker image to the Docker registry (replace with your details)
          docker.withRegistry('https://xxxxxxxxxx', 'xxxxxxxxxxxxxxxxx') {
            docker.image(dockerImageTag).push()
          }
        }
      }
    }
  }
}
