pipeline {
    agent any
    
    environment {
        SNOWFLAKE_ACCOUNT = "kx23846.ap-southeast-1.snowflakecomputing.com"
        USERNAME = "mark"
        PASSWORD = "Mark6789*"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'develop', credentialsId: 'GH-credentials', url: 'https://github.com/nishants15/liquibase.git'
            }
        }
        
        stage('Liquibase') {
            steps {
                sh '''
                    # Set Liquibase environment variables
                    export SNOWFLAKE_ACCOUNT=${SNOWFLAKE_ACCOUNT}
                    export USERNAME=${USERNAME}
                    export PASSWORD=${PASSWORD}
                    
                    # Run Liquibase commands
                    cd functions-liquibase
                    
                    # Select the database
                    echo "USE DATABASE demo;" > select_database.sql
                    snowsql -a ${SNOWFLAKE_ACCOUNT} -u ${USERNAME} -p ${PASSWORD} -f select_database.sql
                    
                    # Run Liquibase update
                    liquibase --changeLogFile=master.xml --url="jdbc:snowflake://${SNOWFLAKE_ACCOUNT}/?db=demo" --username=${USERNAME} --password=${PASSWORD} update
                '''
            }
        }
    }
}
