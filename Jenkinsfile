pipeline {
    agent any
    
    environment {
        SNOWSQL_VERSION = "1.2.27"
        LIQUIBASE_VERSION = "4.12.0"
        SNOWSQL_PATH = "~/bin/snowsql"
        LIQUIBASE_PATH = "/usr/local/bin/liquibase"
        SNOWFLAKE_CONNECTION = "my_connection"
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Clone the GitHub repository
                git branch: 'develop', credentialsId: 'GH-credentials', url: 'https://github.com/nishants15/liquibase.git'
            }
        }
        
        stage('Install SnowSQL') {
            steps {
                script {
                    sh """
                    if [ ! -f ${SNOWSQL_PATH} ]; then
                        curl -o ${SNOWSQL_PATH} https://sfc-repo.snowflakecomputing.com/snowsql/bootstrap/${SNOWSQL_VERSION}/darwin_x86_64/snowsql.gz && gunzip ${SNOWSQL_PATH} && chmod +x ${SNOWSQL_PATH}
                    fi
                    """
                }
            }
        }
        
        stage('Install Liquibase') {
            steps {
                script {
                    sh """
                    if [ ! -f ${LIQUIBASE_PATH} ]; then
                        curl -o ${LIQUIBASE_PATH} https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz && tar -xzf ${LIQUIBASE_PATH} && chmod +x ${LIQUIBASE_PATH}
                    fi
                    """
                }
            }
        }
        
        stage('Run Liquibase Commands') {
            steps {
                dir('functions-liquibase') {
                    script {
                        sh "sudo -u ec2-user ${SNOWSQL_PATH} -c ${SNOWFLAKE_CONNECTION} -f ${LIQUIBASE_PATH}/liquibase --changeLogFile=master.xml --url=jdbc:snowflake://${connections.my_connection.accountname}/${connections.my_connection.dbname}?warehouse=${connections.my_connection.warehousename}&schema=${connections.my_connection.schemaname} --username=${connections.my_connection.username} --password=${connections.my_connection.password} update"
                    }
                }
            }
        }
    }
}
