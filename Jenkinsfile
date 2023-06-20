pipeline {
  agent any
  environment {
    AWS_ACCESS_KEY_ID = "${env.AWS_ACCESS_KEY_ID}"
    AWS_SECRET_ACCESS_KEY = "${env.AWS_SECRET_ACCESS_KEY}"
  }
  stages {
    stage('Connect to Snowflake') {
      steps {
        // Execute the Snowflake command-line client to establish a connection
        sh 'sudo -u ec2-user snowsql -c my_connection'
      }
    }
    stage('Transfer Data to Snowflake') {
      steps {
        // Use AWS CLI commands to copy data from S3 to local directory
        sh "aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}"
        sh "aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}"
        sh 'aws s3 cp s3://snowflakeinput11/campaign /tmp/data.csv'
        
        // Execute Snowflake command to load data from the local file to Snowflake table
        sh 'sudo -u ec2-user snowsql -c my_connection -q "COPY INTO stg_campaign1 FROM @s3_stage/file.csv;"'
      }
    }
    // Add more stages for your CI/CD process
  }
}

