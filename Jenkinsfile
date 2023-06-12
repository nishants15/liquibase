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
                dir(LIQUIBASE_DIR) {
                    sh "unzip -q liquibase.zip"
                }
                sh "curl -Ls ${SNOWFLAKE_JDBC_URL} -o ${SNOWFLAKE_JDBC_PATH}"
                
                // Set the execute permission for Liquibase
                sh "chmod +x ${LIQUIBASE_JAR_PATH}"
            }
        }

        stage('Configure Snowflake') {
            steps {
                // Set Snowflake environment variables
                sh "echo 'export SNOWFLAKE_ACCOUNT=${SNOWFLAKE_ACCOUNT}' >> ~/.bashrc"
                sh "echo 'export SNOWFLAKE_USER=${SNOWFLAKE_USER}' >> ~/.bashrc"
                sh "echo 'export SNOWFLAKE_PWD=${SNOWFLAKE_PWD}' >> ~/.bashrc"
            }
        }

        stage('Clone GitHub Repository') {
            steps {
                script {
                    // Check if the directory already exists
                    if (!fileExists(LIQUIBASE_DIR)) {
                        // Clone the GitHub repository
                        sh "git clone ${GITHUB_REPO} ${LIQUIBASE_DIR}"
                    } else {
                        echo "Skipping cloning step: Directory already exists"
                    }
                }
            }
        }

        stage('Download Liquibase') {
            steps {
                sh "rm -f liquibase.zip"
                sh "wget -q https://github.com/liquibase/liquibase/releases/download/v4.12.0/liquibase-4.12.0.zip -O liquibase.zip"
                sh "unzip -q liquibase.zip -d /var/lib/jenkins/workspace/liquibase-pipe_develop/liquibase"
            }
        }

        stage('Run Liquibase Commands') {
            steps {
                script {
                    // Disable rate limit check for GitHub API
                    env.DISABLE_GITHUB_RATE_LIMIT_CHECK = "true"
                }
                dir("${LIQUIBASE_DIR}/${CHANGELOG_DIRECTORY}") {
                    // Execute Liquibase commands
                    sh "java -jar ${LIQUIBASE_DIR}/liquibase.jar --changeLogFile=master.xml --url=jdbc:snowflake://${SNOWFLAKE_ACCOUNT}/ --username=${SNOWFLAKE_USER} --password=${SNOWFLAKE_PWD} update"
                    // Add more Liquibase commands here
                }
            }
        }
    }
}

def fileExists(String path) {
    return new File(path).exists()
}
