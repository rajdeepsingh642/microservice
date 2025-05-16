pipeline {
    agent  any
    stages {
        stage('Git Checkout') {
            steps {
               git 'https://github.com/rajdeepsingh642/microservice.git'
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
        
         stage('Deploy to k8s') {
            steps {
                withKubeConfig(
                    caCertificate: '''-----BEGIN CERTIFICATE-----
MIIDBTCCAe2gAwIBAgIIKgv8JbkNT3QwDQYJKoZIhvcNAQELBQAwFTETMBEGA1UE
AxMKa3ViZXJuZXRlczAeFw0yNTA1MTMwNTQzNTRaFw0zNTA1MTEwNTQ4NTRaMBUx
EzARBgNVBAMTCmt1YmVybmV0ZXMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQDLxRWVuIvnmbjpvJeFEGzXWscN4aDX1UdMjV+9SJ/dwaUsCjTe78cbhqjL
ZCWMV6uEg6ueU00KLMd830aLT5jFIwmZaQHAEsCJ8JNNRCcjf72HPtR00+/CwfhN
R7NxaYWM6vagZIEn4/nhZ4qhMowkP2AZ084oeuVcOJMfA1TMZBSHKz3iMJi+2nAZ
VhZdd/BpBWW5KXEiso1V+mTYfwbHiqAOIuIk/0pQDvhYqLNATrR0K2j5RVzuF+GC
zD08U/wyc03HcN57vVZaXgeEpvWIjjchOAnxDqDWOjy13AmVOYVNhzUiKKK9uZO8
GZBwuKEQ02qHNXjG89E6fDNHbJxvAgMBAAGjWTBXMA4GA1UdDwEB/wQEAwICpDAP
BgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSkfbES6WKmfNS6iIMWyEUwz+Q+kjAV
BgNVHREEDjAMggprdWJlcm5ldGVzMA0GCSqGSIb3DQEBCwUAA4IBAQCNXCFQ4p97
KmXm+VXxwRLe1rF6DlmdBxGQ86HfaIWczmI0pKbkX2MuoPwas9SEeyYE9+5O5p06
Z0B+mR1wcwiMSHzZa5RXfCRDpaT/qUpN4wwP55GT1QMjxT3468SicvC89G/tytVl
8Oe5RVtEqdyWhNTxj3ubazSgg33c0itgRtvhionGYWLIfT/IRKvqY3bEptO9b8mK
N3+HNbb99H/HKKF8OZVDtrBQ3iAD7yx3kjX3rWZUKlTmR7txuZsuJl/G29RnDacV
EG3TAqBl25PwhbP3buSywNzwmh63b2qvz5EQq7ix30R3/mNT0W9oTetian/3PN1D
0bccuS4slJS8
-----END CERTIFICATE-----''',
                    credentialsId: 'k8s-token',
                    serverUrl: 'https://192.168.33.132:6443'
                ) {
                    sh 'kubectl apply -f ./k8s/observability.yaml'
                    sh  'kubectl apply -f ./k8s/java-deployment.yml'
                }
            }
        
        }
        
        
        
        
    }
}
