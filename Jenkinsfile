pipeline {
    agent any

    environment {
        LIQUIBASE_VERSION = '4.12.0'
        SNOWFLAKE_JDBC_VERSION = '3.15.1'
        LIQUIBASE_URL = "https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.zip"
        SNOWFLAKE_JDBC_URL = "https://repo1.maven.org/maven2/net/snowflake/snowflake-jdbc/${SNOWFLAKE_JDBC_VERSION}/snowflake-jdbc-${SNOWFLAKE_JDBC_VERSION}.jar"
        SNOWFLAKE_ACCOUNT = 'kx23846.ap-southeast-1.snowflakecomputing.com'
        SNOWFLAKE_USER = 'mark'
        SNOWFLAKE_PWD = 'Mark6789*'
        GITHUB_REPO = 'https://github.com/nishants15/liquibase.git'
        GITHUB_BRANCH = 'develop'
        CHANGELOG_DIRECTORY = 'changelogs'
        LIQUIBASE_DIR = "${env.WORKSPACE}/liquibase"
        LIQUIBASE_HOME = "${LIQUIBASE_DIR}"
        LIQUIBASE_JAR_PATH = "${LIQUIBASE_DIR}/liquibase.jar"
        SNOWFLAKE_JDBC_PATH = "${LIQUIBASE_DIR}/lib/snowflake-jdbc.jar"
    }

    stages {
        stage('Install Dependencies') {
            steps {
                // Download Liquibase and Snowflake JDBC driver
                sh "curl -Ls ${LIQUIBASE_URL} -o ${LIQUIBASE_DIR}/liquibase.zip"
                sh "unzip -q ${LIQUIBASE_DIR}/liquibase.zip -d ${LIQUIBASE_DIR}"
                sh "curl -Ls ${SNOWFLAKE_JDBC_URL} -o ${SNOWFLAKE_JDBC_PATH}"
                
                // Set the execute permission for Liquibase
                sh "chmod +x ${LIQUIBASE_JAR_PATH}"
            }
        }
        
        // Rest of the stages remain the same
    }
}
