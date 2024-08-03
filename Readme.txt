This project consists of a Node.js backend, a React frontend, and MongoDB.

Description: This project involves manually setting up a Kubernetes cluster by configuring master and worker nodes using kubeadm.

Follow these steps to set up the environment for this project.
On the main server:
Step 1: Run Installation Scripts On the main server.
  Run the following scripts on your main server to install necessary tools:
    - jenkins_installation.sh: Sets up the server as a Jenkins server.
    - terraform_installation.sh: Prepares the environment to create the cluster nodes (master node and worker nodes) using Terraform (Infrastructure as Code).
    - nodejs_installation.sh: Installs Node.js for testing and building the application artifact
    - docker_installation.sh: Allows the Jenkins server to use Docker commands, such as building and pushing Docker images.

Step 2: Provide AWS Credentials
  Set the AWS credentials to enable Terraform to create the cluster Nodes:
    export AWS_ACCESS_KEY_ID="anaccesskey"
    export AWS_SECRET_ACCESS_KEY="asecretkey"

Step 3: Create kuberentes cluster nodes with Terraform
  Navigate to the Terraform directory and apply the Terraform configuration:
    cd Terraform
    terraform apply -auto-approve

Step 4: Install Jenkins Plugins
  Install the following Jenkins plugins:
    Multibranch Scan Webhook Trigger
    Pipeline: GitHub Groovy Libraries
    SSH Agent Plugin

Step 5: Jenkins Configuration:
  Create a Username with private key credential:
    In your Jenkins server, create a SSH Username with private key credential to allow Jenkins to access the master node via ssh agent plugin and run application YAML files.

   Create a Username and Password Credential:
    In your Jenkins server, create a Username and Password credential to allow Jenkins to push images to Docker Hub.
      Note: The password will be a Personal Access Token generated in Docker Hub.

Step 6: Configure GitHub Webhook:

Add a webhook in your GitHub repository to connect to your Jenkins server.
You will need to add the IP address of your Jenkins server in the webhook configuration. As in the issue named "Trigger token name for multibranch Scan webhook on Jenkins server".

On the Master Node

Step 7: Run Installation Scripts On the Master Node.
  Run the following scripts on your master node to create the kubernetes cluster:
    - McontainerdDepKubeInitDockerAnsible.sh: Prepares the Kubernetes cluster and its network. Also installs Docker and Ansible on the master node.
	Note: Calico is a networking add-on for the Kubernetes cluster. You can edit your cluster IP range by editing the CALICO_IPV4POOL_CIDR value in calico.yaml.
   - addansiblehosts.sh:  Generates an SSH key on the master node and copies this key to the worker nodes to run tasks on the worker nodes using Ansible playbooks.
 	Note: You need to edit the 'ips' variable to your worker nodes' IPs.
   
Step 8: Move and run Ansible playbooks.
	1 - copy the content of the ansible_tasks directory to /etc/ansible/, using this command [ #sudo mv ansible_tasks/* /etc/ansible/ ].
	2 - Edit the [kubehosts] group in /etc/ansible/hosts with your worker nodes' IPs.
	3 - Run the clustertasks.yml playbook to install Kubernetes on the worker nodes:. using this command [#ansible-playbook /etc/ansible/playbooks/clustertasks.yml].
	4 - Run the joinclustertask.yml playbook to generate a cluster token and allow the worker nodes to join the cluster via this token. using this command [#ansible-playbook /etc/ansible/playbooks/joinclustertask.yml].
