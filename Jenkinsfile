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
