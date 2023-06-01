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
                sh '''
                    # Define variables for Liquibase and Snowflake JDBC driver versions
                    LIQUIBASE_VERSION=4.5.0
                    SNOWFLAKE_JDBC_VERSION=3.15.1

                    # Define variables for the download URLs
                    LIQUIBASE_URL=https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip
                    SNOWFLAKE_JDBC_URL=https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/${SNOWFLAKE_JDBC_VERSION}/snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar

                    # Create a directory for Liquibase and Snowflake JDBC driver
                    mkdir -p /opt/liquibase

                    # Download and extract Liquibase
                    curl -L $LIQUIBASE_URL -o /tmp/liquibase.zip
                    unzip -o /tmp/liquibase.zip -d /opt/liquibase 
                    rm /tmp/liquibase.zip

                    # Download the Snowflake JDBC driver
                    curl -L $SNOWFLAKE_JDBC_URL -o /opt/liquibase/snowflake-jdbc.jar

                    # Create a symlink for the Liquibase binary
                    ln -sf /opt/liquibase/liquibase /usr/local/bin/liquibase

                    # Verify the installation
                    liquibase --version
                '''
            }
        }

        stage('Run Liquibase') {
            steps {
                sh '''
                    liquibase \
                        --classpath=/opt/liquibase/snowflake-jdbc.jar \
                        --driver=net.snowflake.client.jdbc.SnowflakeDriver \
                        --url=jdbc:snowflake://bcb55215.us-east-1.snowflakecomputing.com/?db=DEVOPS_DB&schema=DEVOPS_SCHEMA \
                        --username=Mark \
                        --password=Mark56789* \
                        --changeLogFile=/functions-liquibase/master.xml \
                        update
                '''
            }
        }
    }
}



