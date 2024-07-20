def call() {
	sshagent(['Master_Node_SSH_Cred']) {
        sh 'ssh -o StrictHostKeyChecking=no ubuntu@remote-server "./run_yamls.sh"'
        }          
}
