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
        stage('Install Liquibase') {
            steps {
                sh '''
                    # Define variables for the download URLs
                    LIQUIBASE_URL = "https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip"
                    SNOWFLAKE_JDBC_URL = "https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/${SNOWFLAKE_JDBC_VERSION}/snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar"

                    // Create a directory for Liquibase and Snowflake JDBC driver
                    sh 'mkdir -p /opt/liquibase'

                    // Download and extract Liquibase
                    sh "curl -L $LIQUIBASE_URL -o /tmp/liquibase.zip"
                    sh "unzip -o /tmp/liquibase.zip -d /opt/liquibase"
                    sh "rm /tmp/liquibase.zip"

                    // Download the Snowflake JDBC driver
                    sh "curl -L $SNOWFLAKE_JDBC_URL -o /opt/liquibase/snowflake-jdbc.jar"

                    // Create a symlink for the Liquibase binary
                    sh "ln -sf /opt/liquibase/liquibase /usr/local/bin/liquibase"

                    // Verify the installation
                    sh 'liquibase --version'
                '''
            }
        }

        stage('Run Liquibase') {
            steps {
                sh '''
                    liquibase \
                        --classpath=/opt/liquibase/snowflake-jdbc.jar \
                        --driver=net.snowflake.client.jdbc.SnowflakeDriver \
                        --url=jdbc:snowflake://$SNOWFLAKE_ACCOUNT/?db=demo&schema=public \
                        --username=$SNOWFLAKE_USER \
                        --password=$SNOWFLAKE_PWD \
                        --changeLogFile=functions-liquibase/master.xml \
                    update
                '''
            }
        }
    }
}
