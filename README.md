•	Manually created a EC2 instance, S3 bucket(to store terraform statefile), IAM Role and dynamodb with LockID enabled(to lock the terraform statefile)
•	That IAM ROLE which needs to be attached to the Jenkins Server(EC2 instance) should have following policies-
1.	AmazonEC2FullAccess
2.	AmazonS3FullAccess
3.	AmazonDynamoDBFullAccess
•	Login to Jenkins server Pipeline 
•	 
•	Under pipeline use the following Script
	pipeline {
	    agent any

    stages {
        stage('checkout') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/master']],
                          extensions: [],
                          userRemoteConfigs: [[url: 'https://github.com/account/repository']]
                ])
            }
        }
        
        stage('init') {
            steps {
                sh "terraform init -reconfigure"
            }
        }

        stage('plan') {
            steps {
                sh "terraform plan -lock=false"
            }
        }

        stage("action") {
            steps {
                    echo "Terraform action is --> ${action}"
                    sh "terraform apply -lock=false --auto-approve"
            
            }
        }
    }
}
•	Configure the pipeline and try to build with the parameters.
•	Instance, Vpc  and Security Group, Eip and S3 buckets are created.
   
