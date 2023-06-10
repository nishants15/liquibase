pipeline {
    agent any
    
    environment {
        SNOWFLAKE_ACCOUNT = 'kx23846.ap-southeast-1.snowflakecomputing.com'
        SNOWFLAKE_USER = 'mark'
        SNOWFLAKE_PWD = 'Mark6789*'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'develop']], userRemoteConfigs: [[url: 'https://github.com/nishants15/liquibase.git']]])
            }
        }
        
        stage('Deploy Snowflake Database') {
            steps {
                sh "snowsql -a ${SNOWFLAKE_ACCOUNT} -u ${SNOWFLAKE_USER} -p ${SNOWFLAKE_PWD} -f database/database.sql"
            }
        }
        
        stage('Run Liquibase') {
            steps {
                sh "liquibase --changeLogFile=master.xml --url=jdbc:snowflake://${SNOWFLAKE_ACCOUNT}/demo -username=${SNOWFLAKE_USER} -password=${SNOWFLAKE_PWD} update"
            }
        }
    }
}
