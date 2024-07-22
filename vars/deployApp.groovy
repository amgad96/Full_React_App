def call() {
        // Download the script file 
        sh 'wget -O ./run_yamls.sh https://raw.githubusercontent.com/amgad96/Full_React_App/main/run_yamls.sh'
	sshagent(['Master_Node_SSH_Cred']) {
                // Copy the script to the remote server
                sh 'scp -o StrictHostKeyChecking=no ./run_yamls.sh ubuntu@54.196.238.157:/home/ubuntu/run_yamls.sh'
                // Execute the script on the remote server
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@54.196.238.157 "chmod +x /home/ubuntu/run_yamls.sh && /home/ubuntu/run_yamls.sh"'
        }          
}
