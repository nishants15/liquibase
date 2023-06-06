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

        stage('Run Liquibase') {
            environment {
                LIQUIBASE_VERSION = "4.12.0"
                SNOWFLAKE_JDBC_VERSION = "3.15.1"
                LIQUIBASE_URL = "https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip"
                SNOWFLAKE_JDBC_URL = "https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/${SNOWFLAKE_JDBC_VERSION}/snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar"
                SNOWFLAKE_ACCOUNT = "bcb55215.us-east-1.snowflakecomputing.com"
                SNOWFLAKE_USER = "Mark"
                SNOWFLAKE_PASSWORD = "Mark56789*"
                SNOWFLAKE_JDBC_DRIVER = "/path/to/snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar"
                SNOWFLAKE_CHANGELOG_FILE = "functions-liquibase/master.xml"
            }
            
            steps {
                sh """
                    curl -L -o liquibase-${LIQUIBASE_VERSION}.zip ${LIQUIBASE_URL}
                    unzip liquibase-${LIQUIBASE_VERSION}.zip
                    chmod +x liquibase
                    curl -L -o snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar ${SNOWFLAKE_JDBC_URL}
                    chmod +x snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar
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
