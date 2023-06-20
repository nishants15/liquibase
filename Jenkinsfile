pipeline {
    agent any
    
    environment {
        SNOWSQL_VERSION = "1.2.27"
        LIQUIBASE_VERSION = "4.12.0"
        SNOWSQL_PATH = "/home/ec2-user/bin/snowsql"
        LIQUIBASE_PATH = "/home/ec2-user/bin/liquibase"
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
                        def connections = [
                            my_connection: [
                                accountname: 'itb89569.us-east-1',
                                username: 'Mark',
                                dbname: 'dev_convertr',
                                schemaname: 'stage',
                                warehousename: 'compute_wh',
                                password: 'Mark12345'
                            ]
                        ]
                        
                        sh """
                            ${SNOWSQL_PATH} -c ${SNOWFLAKE_CONNECTION} -f ${LIQUIBASE_PATH}/liquibase \
                            --changeLogFile=master.xml \
                            --url=jdbc:snowflake://${connections.my_connection.accountname}/${connections.my_connection.dbname}?warehouse=${connections.my_connection.warehousename}&schema=${connections.my_connection.schemaname} \
                            --username=${connections.my_connection.username} \
                            --password=${connections.my_connection.password} \
                            update
                            """

                    }
                }
            }
        }
    }
}
