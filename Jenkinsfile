pipeline {
    agent  any
    stages {
        stage('Git Checkout') {
            steps {
               git 'https://github.com/rajdeepsingh642/microservice.git'
            }
        }

        

       
        stage('Build Docker Image and Tag') {
            steps {
                script {
                    sh "docker build -t rajdeepsingh642/micro-service:latest ."
                }
            }
        }

        stage('Docker Image Scan') {
            steps {
                sh '''
                    trivy image --format table -o trivy-image-report.html rajdeepsingh642/micro-service:latest
                '''
            }
        }

        stage('Docker Image Push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                            docker push rajdeepsingh642/micro-service:latest
                        '''
                    }
                }
            }
        }
    }
}
