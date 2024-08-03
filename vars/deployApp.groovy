/*def call() {
        echo "test the shared libray with post"
        // Download the script file 
        sh 'wget -O ./run_yamls.sh https://raw.githubusercontent.com/amgad96/Full_React_App/main/run_yamls.sh'
	sshagent(['Master_Node_SSH_Cred']) {
                // Copy the script to the remote server
                sh 'scp -o StrictHostKeyChecking=no ./run_yamls.sh ubuntu@<master_node_IP>:/home/ubuntu/run_yamls.sh'
                // Execute the script on the remote server
                sh 'ssh -o StrictHostKeyChecking=no ubuntu@<master_node_IP> "chmod +x /home/ubuntu/run_yamls.sh && /home/ubuntu/run_yamls.sh"'
        }        
}*/
//Another way 
def call() {
    sshagent(['Master_Node_SSH_Cred']) {
        sh """
        ssh -o StrictHostKeyChecking=no ubuntu@<master_node_IP> <<EOF
        rm -rf cluster_dir
        git clone -b App_Kube_cluster https://github.com/amgad96/Full_React_App.git cluster_dir
        cd cluster_dir
        sudo kubectl apply -f DB-PersistentVol.yaml
        sudo kubectl apply -f MongoDB-DS.yaml
        sudo kubectl apply -f Backend-DS.yaml
        sudo kubectl apply -f Frontend-DS.yaml
        cd ..
        rm -rf cluster_dir
EOF
        """
    }
}
