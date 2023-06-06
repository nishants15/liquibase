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
                withEnv([
                    "LIQUIBASE_VERSION=${LIQUIBASE_VERSION}",
                    "LIQUIBASE_URL=https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip"
                ]) {
                    sh '''
                        curl -L -o liquibase-${LIQUIBASE_VERSION}.zip ${LIQUIBASE_URL}
                        unzip -n liquibase-${LIQUIBASE_VERSION}.zip
                    '''
                }
            }
        }

        stage('Run Liquibase') {
            environment {
                SNOWFLAKE_ACCOUNT = "bcb55215.us-east-1.snowflakecomputing.com"
                SNOWFLAKE_USER = "Mark"
                SNOWFLAKE_PASSWORD = "Mark56789*"
                SNOWFLAKE_JDBC_DRIVER = "/path/to/snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar"
                SNOWFLAKE_CHANGELOG_FILE = "functions-liquibase/master.xml"
            }
            
            steps {
                sh """
                    ./liquibase --driver=com.snowflake.client.jdbc.SnowflakeDriver \
                                --classpath=${SNOWFLAKE_JDBC_DRIVER} \
                                --changeLogFile=${SNOWFLAKE_CHANGELOG_FILE} \
                                --url=jdbc:snowflake://${SNOWFLAKE_ACCOUNT} \
                                --username=${SNOWFLAKE_USER} \
                                --password=${SNOWFLAKE_PASSWORD} \
                                update
                """
            }
        }
    }
}
