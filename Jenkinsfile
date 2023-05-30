pipeline {
  agent any
  
  stages {
    stage('Checkout') {
      steps {
        // Checkout your repository code
        git 'https://github.com/nishants15/liquibase.git'
      }
    }
    
    stage('Build') {
      steps {
        // Add your build steps here
        sh 'echo "Building..."'
      }
    }
    
    stage('Test') {
      steps {
        // Add your test steps here
        sh 'echo "Testing..."'
      }
    }
    
    stage('Deploy') {
      steps {
        // Add your deployment steps here
        sh 'echo "Deploying..."'
      }
    }
  }
}
