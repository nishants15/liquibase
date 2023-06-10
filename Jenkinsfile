pipeline {
    agent any
    environment {
        SNOWFLAKE_ACCOUNT = "kx23846.ap-southeast-1.snowflakecomputing.com"
        USERNAME = "mark"
        PASSWORD = "Mark6789*"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'develop', credentialsId: 'GH-credentials', url: 'https://github.com/nishants15/liquibase.git'
            }
        }
        stage('Liquibase') {
            steps {
                sh 'liquibase --changeLogFile=db.master.xml --url=jdbc:snowflake://${SNOWFLAKE_ACCOUNT}/demo --username=${USERNAME} --password=${PASSWORD} update'
            }
        }
    }
}