pipeline {
    agent any
    
    environment {
        LIQUIBASE_VERSION = "4.12.0"
        SNOWFLAKE_JDBC_VERSION = "3.15.1"
        LIQUIBASE_URL = "https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip"
        SNOWFLAKE_JDBC_URL = "https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/${SNOWFLAKE_JDBC_VERSION}/snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar"
        SNOWFLAKE_ACCOUNT = "kx23846.ap-southeast-1.snowflakecomputing.com"
        USERNAME = "mark"
        PASSWORD = "Mark6789*"
    }
    
    stages {
        stage('Install Liquibase') {
            steps {
                sh '''
                    # Create a directory for Liquibase and Snowflake JDBC driver
                    sudo mkdir -p /opt/liquibase

                    # Download and extract Liquibase
                    curl -L ${LIQUIBASE_URL} -o /tmp/liquibase.zip
                    sudo unzip -o /tmp/liquibase.zip -d /opt/liquibase 
                    sudo rm /tmp/liquibase.zip

                    # Download the Snowflake JDBC driver
                    sudo curl -L ${SNOWFLAKE_JDBC_URL} -o /opt/liquibase/snowflake-jdbc.jar

                    # Create a symlink for the Liquibase binary
                    sudo ln -sf /opt/liquibase/liquibase /usr/local/bin/liquibase

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
                        --url=jdbc:snowflake://${SNOWFLAKE_ACCOUNT}/?db=DEVOPS_DB&schema=DEVOPS_SCHEMA \
                        --username=${USERNAME} \
                        --password=${PASSWORD} \
                        --changeLogFile=functions-liquibase/master.xml \
                        update
                '''
            }
        }
    }
}
