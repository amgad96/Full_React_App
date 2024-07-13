pipeline {
    agent any
//This command to check  
    stages {           
      stage('Build') {
            steps {
                    script {
                        sh 'npm install'
                        sh 'npm run build'
                            }
                        }
                    }

        stage('Test') {
            steps {
                    script {
                        sh 'npm install'
                        sh 'npm test'
                    }
                }
            }
               
/*
        stage('Build Docker Images') {
                    steps {
                        script {
                            docker.withRegistry('', 'docker-creds') {
                                sh 'docker build -t docker push amgadashraf/ffrontend:v5 frontend'
                                sh 'docker push amgadashraf/ffrontend:v5'
                            }
                        }
                    }
        }
    
*/
        stage('Deploy') {
            steps {
                // Add your deployment steps here
                echo 'Deploying Frontend and Backend...'
            }
        }
    }

    post {
        always {
            cleanWs() // Clean the workspace after the build
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}

