pipeline {
    agent any
    
    environment {
        SNOWFLAKE_ACCOUNT = "kx23846.ap-southeast-1.snowflakecomputing.com"
        USERNAME = "mark"
        PASSWORD = "Mark6789*"
        SNOWSQL_PATH = "/home/ec2-user/bin/snowsql" // Update this line with the correct SnowSQL path
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'develop', credentialsId: 'GH-credentials', url: 'https://github.com/nishants15/liquibase.git'
            }
        }
        
        stage('Liquibase') {
            steps {
                script {
                    sh """
                    cd functions-liquibase

                    echo 'USE DATABASE demo;' > select_database.sql
                    sudo /home/ec2-user/bin/snowsql -q 'USE DATABASE demo;'
                    """
                }
            }
        }