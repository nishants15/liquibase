pipeline {
    agent any

    environment {
        LIQUIBASE_VERSION = 'latest'  // Set to 'latest' to install the latest version of Liquibase
        SNOWFLAKE_ACCOUNT = 'kx23846.ap-southeast-1.snowflakecomputing.com'
        SNOWFLAKE_USER = 'mark'
        SNOWFLAKE_PWD = 'Mark6789*'
        GITHUB_REPO = 'https://github.com/nishants15/liquibase.git'
        GITHUB_BRANCH = 'develop'
        CHANGELOG_DIRECTORY = 'changelogs'  // Update this to the appropriate directory where your changelog files are located
        LIQUIBASE_JAR_PATH = "${env.WORKSPACE}/liquibase.jar"
    }

    stages {
        stage('Install Liquibase') {
            steps {
                script {
                    // Download Liquibase JAR if it doesn't exist
                    sh "curl -Ls https://github.com/liquibase/liquibase/releases/${env.LIQUIBASE_VERSION}/download/liquibase-core-${env.LIQUIBASE_VERSION}.jar -o ${env.LIQUIBASE_JAR_PATH}"
                }
            }
        }

        stage('Configure Snowflake') {
            steps {
                // Set Snowflake environment variables
                sh "echo 'export SNOWFLAKE_ACCOUNT=${env.SNOWFLAKE_ACCOUNT}' >> ~/.bashrc"
                sh "echo 'export SNOWFLAKE_USER=${env.SNOWFLAKE_USER}' >> ~/.bashrc"
                sh "echo 'export SNOWFLAKE_PWD=${env.SNOWFLAKE_PWD}' >> ~/.bashrc"
            }
        }

        stage('Clone GitHub Repository') {
            steps {
                script {
                    // Check if the directory already exists
                    def liquibaseDir = "${env.WORKSPACE}/liquibase"
                    if (!fileExists(liquibaseDir)) {
                        // Clone the GitHub repository
                        sh "git clone ${env.GITHUB_REPO} ${liquibaseDir}"
                    } else {
                        echo "Skipping cloning step: Directory already exists"
                    }
                }
            }
        }

        stage('Run Liquibase Commands') {
            steps {
                dir("${env.WORKSPACE}/liquibase/${env.CHANGELOG_DIRECTORY}") {
                    // Execute Liquibase commands
                    sh "java -jar ${env.LIQUIBASE_JAR_PATH} --changeLogFile=database.xml --url=jdbc:snowflake://${env.SNOWFLAKE_ACCOUNT}/ --username=${env.SNOWFLAKE_USER} --password=${env.SNOWFLAKE_PWD} update"
                    // Add more Liquibase commands here
                }
            }
        }
    }
}

def fileExists(String path) {
    return new File(path).exists()
}
