/* groovylint-disable LineLength */
pipeline {
    agent any 
    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-terraform')
        AWS_SECRET_ACCESS_KEY = credentials('aws-terraform')
    }
    stages {
        stage('Cleanup') {
            steps {
                sh 'rm -rf automate-terraform-ci-cd-jenkins || true'
            }
        }
        stage('Git Checkout') {
            steps {
                sh 'git clone https://github.com/yuvaraj-1991/automate-terraform-ci-cd-jenkins.git'
            }
        }
        stage('Check for Packages Ansible & terraform if not present Install it') {
            steps {
                sh 'echo "Checking if ansible is installed on the machine"'
                sh '''
                    if ! command -v ansible &> /dev/null; then
                        echo "Ansible is not installed. Installing it now!!!"
                        sudo apt update -y
                        sudo apt install ansible -y
                    else
                        echo "Ansible is already installed"
                    fi
                    if ! terraform --version >/dev/null 2>&1; then
                        echo "Terraform is not installed. Installing it now!!!"
                        sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
                        wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
                        echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
                        sudo apt-get update && sudo apt-get install -y terraform
                    else
                        echo "Terraform is already Installed"
                    '''
            }
        }
    
        stage('Terraform Initialize') {
            steps {
                sh 'cd automate-terraform-ci-cd-jenkins/terraform'
                sh 'terraform init'                
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'                
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'                
            }
        }
        stage('Extracting IP Address from output file') {
            steps {
                sh 'terraform output -raw public-ip-ec2-instance > ec2_ip.txt'                
            }
        }
        stage('Create Ansible Inventory file') {
            steps {
                sh '''
                    echo "[web]" > inventory.ini
                    cat ec2_ip.txt >> inventory.ini
                    echo "ansible_user=ubuntu ansible_ssh_private_key_file=/home/yuvaraj/Downloads/linux-01.pem" >> inventory.ini
                '''                
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                sh 'ansible-playbook -i inventory.ini server-setup-web.yml'                
            }
        }
    }
}
