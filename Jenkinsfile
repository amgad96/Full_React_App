pipeline {
    agent any 
    stages {
        stage('Apply cluster yaml files') {
            steps {
                script {
                    sshagent(['Master_Node_SSH_Cred']) {
                        sh """
                        ssh -o StrictHostKeyChecking=no ubuntu@remote-server <<EOF
                        git clone -b App_Kube_cluster https://github.com/amgad96/Full_React_App.git
                        cd Full_React_App
                        Kubectl apply -f DB-PersistentVol.yaml
                        Kubectl apply -f MongoDB-DS.yaml
                        Kubectl apply -f Backend-DS.yaml
                        Kubectl apply -f Frontend-DS.yaml
                        cd ..
                        rm -rf Full_React_App
                        EOF
                        """
                    }
                }
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
