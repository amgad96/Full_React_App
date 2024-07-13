pipeline {
    agent any
//This command to check  
    stages {
       stage('Installing Backend dependencies') {
                    steps {
                        script {
                            sh '''
                                npm update
                                npm install --save-dev jest supertest
                                npm install express
                                npm install --save-dev @babel/cli @babel/core @babel/preset-env
                                '''
                            }
                        }
                    }
                
      stage('Build Backend') {
            steps {
                    script {
                        sh 'npm run build'
                    }
                }
            }

        stage('Test Backend') {
            steps {
                    script {
                        sh 'npm test'
                    }
                }
            }
/*
        stage('Build Backend Docker Image') {
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
