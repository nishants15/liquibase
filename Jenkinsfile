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
                script {
                    // Define variables for Liquibase and Snowflake JDBC driver versions
                    def LIQUIBASE_VERSION = "4.12.0"
                    def SNOWFLAKE_JDBC_VERSION = "3.15.1"

                    // Define variables for the download URLs
                    def LIQUIBASE_URL = "https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip"
                    def SNOWFLAKE_JDBC_URL = "https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/${SNOWFLAKE_JDBC_VERSION}/snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar"

                    // Create a directory for Liquibase and Snowflake JDBC driver
                    sh 'sudo mkdir -p /opt/liquibase'

                    // Download and extract Liquibase
                    sh "curl -L ${LIQUIBASE_URL} -o /tmp/liquibase.zip"
                    sh 'sudo unzip -o /tmp/liquibase.zip -d /opt/liquibase'
                    sh 'sudo rm /tmp/liquibase.zip'

                    // Download the Snowflake JDBC driver
                    sh "sudo curl -L ${SNOWFLAKE_JDBC_URL} -o /opt/liquibase/snowflake-jdbc.jar"

                    // Create a symlink for the Liquibase binary
                    sh 'sudo ln -sf /opt/liquibase/liquibase /usr/local/bin/liquibase'

                    // Verify the installation
                    sh 'liquibase --version'
                }
            }
        }

        stage('Run Liquibase') {
            steps {
                script {
                    withEnv([
                        "SNOWFLAKE_ACCOUNT=kx23846.ap-southeast-1.snowflakecomputing.com",
                        "USERNAME=mark",
                        "PASSWORD=Mark56789*"
                    ]) { 
                        sh '''
                            liquibase \
                                --classpath=/opt/liquibase/snowflake-jdbc.jar \
                                --driver=net.snowflake.client.jdbc.SnowflakeDriver \
                                --url=jdbc:snowflake://$SNOWFLAKE_ACCOUNT/?db=DEVOPS_DB&schema=DEVOPS_SCHEMA \
                                --username=$USERNAME \
                                --password=$PASSWORD \
                                --changeLogFile=/db/aiml/master.xml \
                                update
                        '''
                    }
                }
            }
        }

        post {
            always {
                cleanWs()
            }
        }
    }
}
