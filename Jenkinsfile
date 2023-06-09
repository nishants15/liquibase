pipeline {
    agent any
    
    environment {
        SNOWFLAKE_ACCOUNT = "kx23846.ap-southeast-1.snowflakecomputing.com"
        USERNAME = "mark"
        PASSWORD = "Mark6789*"
        SNOWSQL_PATH = "/root/bin/snowsql" // Update this line with the correct SnowSQL path
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
                        # Run Liquibase commands
                        cd functions-liquibase
                        
                        # Select the database
                        echo "USE DATABASE demo;" > select_database.sql
                        /root/bin/snowsql -a ${SNOWFLAKE_ACCOUNT} -u ${USERNAME} -p ${PASSWORD} -f select_database.sql
                        
                        # Run Liquibase update
                        liquibase --changeLogFile=master.xml --url="jdbc:snowflake://${SNOWFLAKE_ACCOUNT}/?db=demo" --username=${USERNAME} --password=${PASSWORD} update
                        '''
            }
        }
    }
}
