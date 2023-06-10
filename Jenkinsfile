pipeline {
    agent any

    environment {
        LIQUIBASE_VERSION = '4.12.0'
        SNOWFLAKE_JDBC_VERSION = '3.15.1'
        SNOWFLAKE_ACCOUNT = 'kx23846.ap-southeast-1.snowflakecomputing.com'
        SNOWFLAKE_USER = 'mark'
        SNOWFLAKE_PWD = 'Mark6789*'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'develop', url: 'https://github.com/nishants15/liquibase.git'
            }
        }

        stage('Install Liquibase') {
            steps {
                script {
                    // Download and extract Liquibase
                    sh "curl -L https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip -o /tmp/liquibase.zip"
                    sh "unzip -o /tmp/liquibase.zip -d /opt/liquibase"

                    // Download the Snowflake JDBC driver
                    sh "curl -L https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/${SNOWFLAKE_JDBC_VERSION}/snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar -o /opt/liquibase/snowflake-jdbc.jar"

                    // Create a symlink for the Liquibase binary
                    sh "ln -sf /opt/liquibase/liquibase /usr/local/bin/liquibase"

                    // Verify the installation
                    sh "liquibase --version"
                }
            }
        }

        stage('Run Liquibase') {
            steps {
                script {
                    // Change to the functions-liquibase directory
                    dir('functions-liquibase') {
                        // Run Liquibase update
                        sh '''
                            liquibase \
                                --classpath=/opt/liquibase/snowflake-jdbc.jar \
                                --driver=net.snowflake.client.jdbc.SnowflakeDriver \
                                --url=jdbc:snowflake://$SNOWFLAKE_ACCOUNT/?db=demo&schema=public \
                                --username=$SNOWFLAKE_USER \
                                --password=$SNOWFLAKE_PWD \
                                --changeLogFile=master.xml \
                                update
                        '''
                    }
                }
            }
        }
    }
}
