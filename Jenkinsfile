pipeline {
    agent any

    environment {
        SNOWFLAKE_ACCOUNT = 'kx23846.ap-southeast-1.snowflakecomputing.com'
        SNOWFLAKE_USER = 'mark'
        SNOWFLAKE_PWD = 'Mark6789*'
        GITHUB_REPO = 'https://github.com/nishants15/liquibase.git'
        GITHUB_BRANCH = 'develop'
        CHANGELOG_DIRECTORY = 'changelogs'
        LIQUIBASE_JAR_PATH = "/mnt/c/Users/nishant.sharma_appli/downloads/liquibase.jar"
    }

    stages {
        stage('Configure Snowflake') {
            steps {
                sh "echo 'export SNOWFLAKE_ACCOUNT=${env.SNOWFLAKE_ACCOUNT}' >> ~/.bashrc"
                sh "echo 'export SNOWFLAKE_USER=${env.SNOWFLAKE_USER}' >> ~/.bashrc"
                sh "echo 'export SNOWFLAKE_PWD=${env.SNOWFLAKE_PWD}' >> ~/.bashrc"
            }
        }

        stage('Clone GitHub Repository') {
            steps {
                script {
                    def liquibaseDir = "${env.WORKSPACE}/liquibase"
                    if (!fileExists(liquibaseDir)) {
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
                    sh "java -jar ${env.LIQUIBASE_JAR_PATH} --changeLogFile=database.xml --url=jdbc:snowflake://${env.SNOWFLAKE_ACCOUNT}/ --username=${env.SNOWFLAKE_USER} --password=${env.SNOWFLAKE_PWD} update"
                }
            }
        }
    }
}

def fileExists(String path) {
    return new File(path).exists()
}
