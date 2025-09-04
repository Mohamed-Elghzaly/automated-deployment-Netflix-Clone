pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')  
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key') 
    }

    stages {
        stage('Terraform Init') {
            steps {
                sh '''
                cd terraform
                terraform init
                '''
            }
        }
        stage('Terraform Plan') {
            steps {
                sh '''
                cd terraform
                terraform plan
                '''
            }
        }

        stage('Terraform Action') {
            steps {
                script {
                    def userInput = input(
                        id: 'userInput', message: 'Choose Terraform Action',
                        parameters: [
                            choice(
                                name: 'ACTION',
                                choices: ['apply', 'destroy', 'none'],
                                description: 'Select Terraform action to perform'
                            )
                        ]
                    )

                    if (userInput == 'apply') {
                        sh '''
                        cd terraform
                        terraform apply -auto-approve
                        echo "[app_servers]" > ../inventory
                        echo "$(terraform output -raw instance_public_ip)" >> ../inventory
                        echo "[all:vars]" >> ../inventory
                        echo "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../inventory
                        echo "ansible_ssh_private_key_file=$(realpath mykey.pem)"  >> ../inventory
                        echo "ansible_user=ubuntu"  >> ../inventory
                        '''
                    } else if (userInput == 'destroy') {
                        sh '''
                        cd terraform
                        terraform destroy -auto-approve
                        '''
                        echo "Terraform destroy completed. Stopping pipeline..."
                        currentBuild.result = 'ABORTED'
                        error('Stopping early…')
                    } else if (userInput == 'none') {
                        sh '''
                        cd terraform
                        echo "[app_servers]" > ../inventory
                        echo "$(terraform output -raw instance_public_ip)" >> ../inventory
                        echo "[all:vars]" >> ../inventory
                        echo "ansible_ssh_common_args='-o StrictHostKeyChecking=no'" >> ../inventory
                        echo "ansible_ssh_private_key_file=$(realpath mykey.pem)"  >> ../inventory
                        echo "ansible_user=ubuntu"  >> ../inventory
                        '''
                    }
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t mohamed010/netflix-clone .'
            }
        }


        stage('Wait for SSH') {
            steps {
                script {
                    // take IP from Terraform
                    SERVER_IP = sh(script: "cd terraform && terraform output -raw instance_public_ip", returnStdout: true).trim()
                    echo "Waiting for SSH on $SERVER_IP"

                    // Retry loop: try 20 times every 10 seconds
                    sh """
                    for i in {1..20}; do
                        nc -z -w5 $SERVER_IP 22 && break
                        echo "SSH not ready yet, retrying..."
                        sleep 10
                    done
                    """
                }
            }
        }


        stage('Run Ansible') {
            steps {
                    sh '''
                        SERVER_IP=$(grep -v '^\\[' inventory | head -n 1)
                        echo "Using SERVER_IP=$SERVER_IP"

                        ssh-keyscan -H $SERVER_IP >> ~/.ssh/known_hosts || true

                        ansible-playbook -i inventory ansible-playbook.yml
                    '''
                }

            }
    }
}
