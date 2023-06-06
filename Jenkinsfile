// Pipeline Initialization
pipeline {
    agent any

    stages {
        stage('Initialization') {
            steps {
                echo 'Pipeline initialized'
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'develop', credentialsId: 'GH-credentials', url: 'https://github.com/nishants15/liquibase.git'
            }
        }

        stage('Install Liquibase') {
            steps {
                sh "curl -L -o liquibase-${LIQUIBASE_VERSION}.zip https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip"
                sh "unzip liquibase-${LIQUIBASE_VERSION}.zip"
                sh "chmod +x liquibase"
            }
        }

        stage('Run Liquibase') {
            environment {
                LIQUIBASE_VERSION = "4.3.5"
                SNOWFLAKE_ACCOUNT = "bcb55215.us-east-1.snowflakecomputing.com"
                SNOWFLAKE_USER = "Mark"
                SNOWFLAKE_PASSWORD = "Mark56789*"
                SNOWFLAKE_JDBC_URL = "jdbc:snowflake://${SNOWFLAKE_ACCOUNT}/?db=DEVOPS_DB&schema=DEVOPS_SCHEMA"
                SNOWFLAKE_CHANGELOG_FILE = "/functions-liquibase/master.xml"
                LIQUIBASE_CLASSPATH = "/opt/liquibase/snowflake-jdbc.jar"
            }

            steps {
                sh """
                    ./liquibase --driver=net.snowflake.client.jdbc.SnowflakeDriver \
                                --classpath=${LIQUIBASE_CLASSPATH} \
                                --changeLogFile=${SNOWFLAKE_CHANGELOG_FILE} \
                                --url=${SNOWFLAKE_JDBC_URL} \
                                --username=${SNOWFLAKE_USER} \
                                --password=${SNOWFLAKE_PASSWORD} \
                                update
                """
            }
        }
    }
}
