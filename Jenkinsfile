pipeline {
    agent any

    environment {
        AWS_ACCOUNT_ID = '740536218642'
        AWS_REGION = 'us-east-1'
        ECR_REPOSITORY_NAME = 'test-jk'
        IMAGE_TAG = "${env.BUILD_ID}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY_NAME}:${IMAGE_TAG}")
                }
            }
        }

        stage('Login to ECR') {
            steps {
                script {
                    withAWS(credentials: 'AWS_test-jk', region: AWS_REGION) {
					sh 'aws sts get-caller-identity' // Verify AWS credentials
					sh 'aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com'
                    }
                }
            }
        }


        stage('Push to ECR') {
            steps {
                script {
                    docker.image("${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY_NAME}:${IMAGE_TAG}").push()
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

