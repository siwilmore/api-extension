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
                rm -rf LBG-API-Extension
                git clone https://github.com/PCMBarber/LBG-API-Extension.git
                cd LBG-API-Extension
                docker-compose down
                docker-compose up -d
                EOF
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