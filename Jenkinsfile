pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = credentials('Amgad-Docker-Cred')
    } 

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

        stage('Build backend docker Image') {
                    steps {
                        script {
                            sh """
                                echo ${DOCKER_CREDENTIALS_ID_PSW} | docker login -u ${DOCKER_CREDENTIALS_ID_USR} --password-stdin
                                docker build -t amgadashraf/fbackend:v6 .
                                docker push amgadashraf/fbackend:v6
                                docker logout
                                """
                            }
                        }
                    }



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
