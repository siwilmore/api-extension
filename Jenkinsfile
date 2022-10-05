pipeline {
    agent any
    stages {
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
                    docker rm --force node-app
                    docker run -d -p 8080:4000 --name node-app stratcastor/node-app:latest
                '''
            }
        }
    }
    post {
            always {
                sh 'docker system prune -f'
            }
        }
}