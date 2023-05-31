pipeline {
    agent {
        docker {
            image 'maven:3.8.3'
            user 'root'
        }
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'develop', credentialsId: 'GH-credentials', url: 'https://github.com/nishants15/liquibase.git'
            }
        }

        stage('Install Liquibase') {
            steps {
                sh '''
                    # Define variables for Liquibase and Snowflake JDBC driver versions
                    LIQUIBASE_VERSION=4.12.0
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

                    # Verify the installation
                    /opt/liquibase/liquibase --version
                '''
            }
        }

        stage('Run Liquibase') {
            steps {
                sh '''
                    /opt/liquibase/liquibase \
                        --classpath=/opt/liquibase/snowflake-jdbc.jar \
                        --driver=net.snowflake.client.jdbc.SnowflakeDriver \
                        --url=jdbc:snowflake://kx23846.ap-southeast-1.snowflakecomputing.com/?db=DEVOPS_DB&schema=DEVOPS_SCHEMA \
                        --username=Mark \
                        --password=Mark56789* \
                        --changeLogFile=/functions-liquibase/master.xml \
                        update
                '''
            }
        }
    }
}

