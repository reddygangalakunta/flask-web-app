pipeline {
    agent any
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-key')
        REGION                = 'us-east-1'
        ECS_CLUSTER           = 'my-cluster'
        ECS_SERVICE           = 'my-service'
        ECS_TASK_DEFINITION   = 'my-task-def'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/reddygangalakunta/flask-web-app.git'
            }
        }
        
        stage('Build') {
            steps {
                script {
                    echo 'Building the app...'
                    sh 'npm install'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    echo 'Running tests...'
                    sh 'npm test'
                }
            }
        }

        stage('Deploy to AWS EC2') {
            steps {
                script {
                    echo 'Deploying Flask Web Application to EC2...'
                    
                    // Copy the entire project directory to your EC2 instance
                    sh 'scp -i /home/yashwanth/Documents/testkey.pem -r flask-web-app ubuntu@ec2-3-83-100-192.compute-1.amazonaws.com:/home/ubuntu/'
                
                    // SSH into the EC2 instance and run necessary setup
                    sh '''ssh -i /home/yashwanth/Documents/testkey.pem ubuntu@ec2-3-83-100-192.compute-1.amazonaws.com << EOF
                        # Navigate to the project directory
                        cd /home/ubuntu/flask-web-app
                
                        # Install Docker if not already installed
                        sudo apt update
                        sudo apt install -y docker.io
                
                        # Build the Docker image
                        sudo docker build -t flask-web-app .
                
                        # Run the Docker container
                        sudo docker run -d -p 5000:5000 flask-web-app
                
                        echo "Flask app deployed and running at http://ec2-3-83-100-192.compute-1.amazonaws.com:5000"
                    EOF'''
                }

            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
        }
    }
}
