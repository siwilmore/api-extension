pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
                docker build -t simonwilmore/apitask:latest -t simonwilmore/apitask:build-$BUILD_NUMBER .
                
                '''
            }
        }
        stage('Push') {
            steps {
                sh ''' 
                 docker push simonwilmore/apitask:latest
                 docker push simonwilmore/apitask:build-$BUILD_NUMBER
                '''
            }
        }
        stage('Run') {
            steps {
                sh '''
                ssh -i "~/.ssh/id_rsa" jenkins@34.133.117.182 << EOF
                docker stop apitask
                docker rm apitask
                docker rmi apitask
                docker run -d -p 80:4000 --name apitask simonwilmore/apitask:latest
                '''
            }
        }
    }
}
