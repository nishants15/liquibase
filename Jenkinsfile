pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout your GitHub repository
                git 'https://github.com/nishants15/liquibase.git'
            }
        }

        stage('Build and Deploy') {
            steps {
                // Build and deploy steps
                // Replace the commands with your build and deploy steps
                sh 'docker build -t my-snowflake-image .'
                sh 'docker run -p 8080:8080 -p 50000:50000 my-jenkins-image'
            }
        }
    }
}
