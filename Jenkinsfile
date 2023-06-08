pipeline {
    agent any
    
    environment {
        SNOWFLAKE_ACCOUNT = "kx23846.ap-southeast-1.snowflakecomputing.com"
        USERNAME = "mark"
        PASSWORD = "Mark6789*"
        DATABASE_NAME = "demo"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'develop', credentialsId: 'GH-credentials', url: 'https://github.com/nishants15/liquibase.git'
            }
        }
        
        stage('Liquibase') {
            steps {
                sh '''
                    # Set Liquibase environment variables
                    export SNOWFLAKE_ACCOUNT=${SNOWFLAKE_ACCOUNT}
                    export USERNAME=${USERNAME}
                    export PASSWORD=${PASSWORD}
                    
                    # Run Liquibase commands
                    cd functions-liquibase
                    liquibase --changeLogFile=functions-liquibase/master.xml --url="jdbc:snowflake://${SNOWFLAKE_ACCOUNT}/?db=${DATABASE_NAME}" --username=${USERNAME} --password=${PASSWORD} update
                '''
            }
        }
    }
}