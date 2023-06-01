pipeline {
    agent {
        docker {
            image 'liquibase/liquibase:4.4.2'
        }
    }
    
    stages {
        stage('Install Liquibase') {
            steps {
                sh '''
                    curl -L https://github.com/liquibase/liquibase/releases/download/v4.4.2/liquibase-4.4.2.zip -o liquibase-4.4.2.zip
                    unzip liquibase-4.4.2.zip
                    rm liquibase-4.4.2.zip
                    ln -sf ${PWD}/liquibase /usr/local/bin/liquibase
                    liquibase --version
                '''
            }
        }
        
        stage('Checkout') {
            steps {
                git branch: 'develop', credentialsId: 'GH-credentials', url: 'https://github.com/nishants15/liquibase.git'
            }
        }
        
        stage('Run Liquibase') {
            steps {
                sh '''
                    LIQUIBASE_VERSION=4.12.0
                    SNOWFLAKE_JDBC_VERSION=3.15.1
                    LIQUIBASE_URL=https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip
                    SNOWFLAKE_JDBC_URL=https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/${SNOWFLAKE_JDBC_VERSION}/snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar

                    mkdir -p /var/lib/jenkins/workspace/liquiiiii_develop/liquibase

                    curl -L $LIQUIBASE_URL -o /var/lib/jenkins/workspace/liquiiiii_develop/liquibase/liquibase-${LIQUIBASE_VERSION}.zip
                    unzip -o /var/lib/jenkins/workspace/liquiiiii_develop/liquibase/liquibase-${LIQUIBASE_VERSION}.zip -d /var/lib/jenkins/workspace/liquiiiii_develop/liquibase
                    rm /var/lib/jenkins/workspace/liquiiiii_develop/liquibase/liquibase-${LIQUIBASE_VERSION}.zip

                    curl -L $SNOWFLAKE_JDBC_URL -o /var/lib/jenkins/workspace/liquiiiii_develop/liquibase/snowflake-jdbc.jar

                    mkdir -p /var/lib/jenkins/liquibase

                    ln -sf /var/lib/jenkins/workspace/liquiiiii_develop/liquibase/liquibase /var/lib/jenkins/liquibase/liquibase

                    /var/lib/jenkins/liquibase/liquibase \
                        --classpath=/var/lib/jenkins/workspace/liquiiiii_develop/liquibase/snowflake-jdbc.jar \
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