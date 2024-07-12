pipeline {
    agent any
    environment {
        AWS_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '740536218642'
        ECR_REPOSITORY = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/test-jk"
        IMAGE_TAG = '10'
    }
    stages {
        stage('Login to ECR') {
            steps {
                script {
                    withAWS(credentials: 'AWS_test-jk', region: "${AWS_REGION}") {
                        // Verify AWS credentials
                        sh 'aws sts get-caller-identity'
                        // Log in to ECR
                        sh 'aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPOSITORY}'
                    }
                }
            }
        }
        stage('Build and Tag Docker Image') {
            steps {
                sh 'docker build -t ${ECR_REPOSITORY}:${IMAGE_TAG} .'
            }
        }
        stage('Push to ECR') {
            steps {
                sh 'docker push ${ECR_REPOSITORY}:${IMAGE_TAG}'
            }
        }
    }
}

