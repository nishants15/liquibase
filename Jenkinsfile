pipeline {
    agent any
    
    environment {
        SNOWFLAKE_ACCOUNT = "kx23846.ap-southeast-1.snowflakecomputing.com"
        USERNAME = "mark"
        PASSWORD = "Mark6789*"
        SNOWSQL_PATH = "/root/bin/snowsql" // Update this line with the correct SnowSQL path
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
                    // Set SnowSQL environment variables
                    env.PATH = "${env.PATH}:${SNOWSQL_PATH}"
                    env.SNOWSQL_CONFIG = "${WORKSPACE}/.snowsql/config"
                    
                    // Write SnowSQL config file
                    writeFile file: env.SNOWSQL_CONFIG, text: """
                    [connections]
                    accountname = ${SNOWFLAKE_ACCOUNT}
                    username = ${USERNAME}
                    password = ${PASSWORD}
                    """
                    
                    // Run SnowSQL commands
                    sh """
                    cd functions-liquibase
                    echo 'USE DATABASE demo;' > select_database.sql
                    ${SNOWSQL_PATH} -f select_database.sql
                    """
                }
            }
        }
    }
}
