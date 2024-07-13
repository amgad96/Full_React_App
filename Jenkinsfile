pipeline {
    agent any

    environment {
        NODE_VERSION = 'v20.15.1' // Specify the Node.js version to use
    }
//This command to check  
    stages {
       stage('Installing dependencies') {
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
                
      stage('Build') {
            parallel {
                stage('Frontend') {
                    steps {
                        dir('dockproject1/frontend') {
                            script {
                                sh 'npm install'
                                sh 'npm run build'
                            }
                        }
                    }
                }
                stage('Backend') {
                    steps {
                        dir('dockproject1/backend') {
                            script {
                                sh 'npm run build'
                            }
                        }
                    }
                }
            }
        }

        stage('Test') {
            parallel {
                stage('Frontend') {
                    steps {
                        dir('dockproject1/frontend') {
                            script {
                                sh 'npm install'
                                sh 'npm test'
                            }
                        }
                    }
                }
                stage('Backend') {
                    steps {
                        dir('dockproject1/backend') {
                            script {
                                sh 'npm test'
                            }
                        }
                    }
                }
            }
        }
/*
        stage('Build Docker Images') {
            parallel {
                stage('Frontend') {
                    steps {
                        script {
                            docker.withRegistry('', 'docker-creds') {
                                sh 'docker build -t docker push amgadashraf/ffrontend:v5 frontend'
                                sh 'docker push amgadashraf/ffrontend:v5'
                            }
                        }
                    }
                }
                stage('Backend') {
                    steps {
                        script {
                            docker.withRegistry('', 'docker-creds') {
                                sh 'docker build -t your-docker-repo/backend:latest backend'
                                sh 'docker push your-docker-repo/backend:latest'
                            }
                        }
                    }
                }
            }
        }*/

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

/*def setupNode() {
    sh '''
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm use $NODE_VERSION
    '''
}
*/