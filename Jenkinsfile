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
                    
                    # Check if SnowSQL exists in /root/bin/
                    if [ -f "/root/bin/snowsql" ]; then
                        /root/bin/snowsql -a ${SNOWFLAKE_ACCOUNT} -u ${USERNAME} -p ${PASSWORD} -f select_database.sql
                    # Check if SnowSQL exists in ~/bin/
                    elif [ -f "~/bin/snowsql" ]; then
                        ~/bin/snowsql -a ${SNOWFLAKE_ACCOUNT} -u ${USERNAME} -p ${PASSWORD} -f select_database.sql
                    else
                        echo "SnowSQL executable not found in expected locations."
                        exit 1
                    fi
                    
                    # Run Liquibase update
                    liquibase --changeLogFile=master.xml --url="jdbc:snowflake://${SNOWFLAKE_ACCOUNT}/?db=demo" --username=${USERNAME} --password=${PASSWORD} update
                '''
            }
        }
    }
}
