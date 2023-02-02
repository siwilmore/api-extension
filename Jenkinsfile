pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
                docker build -t simonwilmore/duotask:latest -t simonwilmore/duotask:build-$BUILD_NUMBER .
                
                '''
            }
        }
        stage('Push') {
            steps {
                sh ''' 
                 docker push simonwilmore/duotask:latest
                 docker push simonwilmore/duotask:build-$BUILD_NUMBER
                '''
            }
        }
        stage('Run') {
            steps {
                sh '''
                ssh -i "~/.ssh/id_rsa" jenkins@34.133.117.182 << EOF
                docker stop duotask
                docker rm duotask
                docker rmi duotask
                docker run -d -p 80:5500 --name duotask simonwilmore/duotask:latest
                '''
            }
        }
    }
}
