pipeline {
    agent any

    environment {
        SNOWFLAKE_ACCOUNT = 'kx23846.ap-southeast-1.snowflakecomputing.com'
        SNOWFLAKE_USER = 'mark'
        SNOWFLAKE_PWD = 'Mark6789*'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your GitHub repository and specify the 'develop' branch
                git branch: 'develop', url: 'https://github.com/nishants15/liquibase.git'
            }
        }

        stage('Build and Deploy') {
            steps {
                sh 'docker build -t my-snowflake-image .' // Build your Snowflake Docker image using the Dockerfile

                sh 'docker run -e SNOWFLAKE_ACCOUNT=$SNOWFLAKE_ACCOUNT ' +
                '-e SNOWFLAKE_USER=$SNOWFLAKE_USER ' +
                '-e SNOWFLAKE_PWD=$SNOWFLAKE_PWD ' +
                'my-snowflake-image /bin/bash -c "liquibase --logLevel=debug update"'
            }
        }
    }
}
