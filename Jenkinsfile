pipeline {
    agent any

    stages {
        stage('Git Checkout') {
            steps {
                git 'https://github.com/rajdeepsingh642/microservice.git'
            }
        }
         stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${env.SONARQUBE}") {
                    sh 'mvn sonar:sonar -Dsonar.projectKey=microservice -Dsonar.host.url=http://192.168.1.42:9000'
                }
            }
        }

        stage('Maven Build') {
            steps {
                echo 'Building the project with Maven...'
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image and Tag') {
            steps {
                script {
                    sh "docker build -t rajdeepsingh642/micro-service:$BUILD_NUMBER ."
                }
            }
        }

        stage('Docker Image Scan') {
            steps {
                sh '''
                    trivy image --format table -o trivy-image-report.html rajdeepsingh642/micro-service:$BUILD_NUMBER
                '''
            }
        }

        stage('Docker Image Push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                            docker push rajdeepsingh642/micro-service:$BUILD_NUMBER
                        '''
                    }
                }
            }
        }

        stage('Update Kubernetes YAML') {
            steps {
                script {
                    sh """
                        sed -i 's|image: rajdeepsingh642/micro-service:.*|image: rajdeepsingh642/micro-service:${BUILD_NUMBER}|' ./k8s/java-deployment.yml
                    """
                }
            }
        }

        stage('Deploy to k8s') {
            steps {
                withKubeConfig(
                    
                    credentialsId: 'k8s-token',
                    serverUrl: 'https://192.168.33.132:6443'
                ) {
                    sh 'kubectl apply -f ./k8s/java-deployment.yml'
                }
            }
        }
    }
}
