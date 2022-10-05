pipeline {
    agent any
    stages {
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Build') {
            steps {
                sh '''
                docker build -t stratcastor/node-app:latest -t stratcastor/node-app:$BUILD_NUMBER .
                '''
            }
        }
        stage('Push') {
            steps {
                sh '''
                docker push stratcastor/node-app:latest
                docker push stratcastor/node-app:$BUILD_NUMBER
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                ssh -i "~/.ssh/id_rsa" jenkins@10.200.0.3 << EOF
                    docker run -p 8080:8080 --name node-app stratcastor/node-app:latest
                EOF
                '''
            }
        }
    }
    post {
            always {
                sh 'docker system prune'
            }
        }
}