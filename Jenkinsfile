pipeline {
    agent any

    environment {
        SNOWFLAKE_ACCOUNT = "kx23846.ap-southeast-1.snowflakecomputing.com"
        USERNAME = "mark"
        PASSWORD = "Mark6789*"
        LIQUIBASE_URL = "https://github.com/liquibase/liquibase/releases/download/v4.12.0/liquibase-4.12.0.zip"
        SNOWFLAKE_JDBC_URL = "https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/3.15.1/snowflake-jdbc-3.15.1.jar"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'develop', credentialsId: 'GH-credentials', url: 'https://github.com/nishants15/liquibase.git'
            }
        }

        stage('Install Liquibase') {
            steps {
                sh '''
                    # Create a directory for Liquibase
                    sudo mkdir -p /opt/liquibase

                    # Download and extract Liquibase
                    curl -L ${env.LIQUIBASE_URL} -o /tmp/liquibase.zip
                    sudo unzip -o /tmp/liquibase.zip -d /opt/liquibase
                    sudo rm /tmp/liquibase.zip

                    # Download the Snowflake JDBC driver
                    sudo curl -L ${env.SNOWFLAKE_JDBC_URL} -o /opt/liquibase/snowflake-jdbc.jar

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
                        --url=jdbc:snowflake://${env.SNOWFLAKE_ACCOUNT}/?db=demo&schema=public \
                        --username=${env.USERNAME} \
                        --password=${env.PASSWORD} \
                        --changeLogFile=functions-liquibase/master.xml \
                        update
                '''
            }
        }
    }
}
