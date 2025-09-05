# Netflix Clone - Automated Deployment

🚀 This project automates the deployment of a **Netflix Clone** application using:

- **Terraform** → Provisioning AWS EC2 instances + Security Groups  
- **Ansible** → Configuration management & application deployment  
- **Jenkins** → CI/CD pipeline automation  
- **Docker** → Containerization for the application  

---

## 📌 Features
- Infrastructure as Code (IaC) with Terraform
- Automated provisioning of EC2 instance on AWS
- Secure SSH key management via Jenkins credentials
- Ansible playbooks for application setup & deployment
- Jenkins pipeline with user input to:
  - `apply` infrastructure
  - `destroy` infrastructure
  - or skip (`none`)
- Dockerized Netflix Clone application

---

## 🛠️ Technologies Used
- **AWS EC2**
- **Terraform**
- **Ansible**
- **Jenkins**
- **Docker**

---

## ⚙️ Pipeline Workflow
1. Jenkins triggers the pipeline.
2. User selects action:
   - `apply` → Creates infrastructure & deploys app  
   - `destroy` → Destroys infrastructure (pipeline ends with SUCCESS)  
   - `none` → Skips execution  
3. Terraform provisions infrastructure.
4. Ansible configures servers and deploys the app.
5. Docker runs the Netflix Clone container.


---
## 📦 Prerequisites
Before you start, make sure you have:

- An **AWS account** with permissions for EC2, VPC, IAM
- **Terraform** installed → [Install Guide](https://developer.hashicorp.com/terraform/downloads)
- **Ansible** installed → [Install Guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
- **Docker** installed → [Install Guide](https://docs.docker.com/get-docker/)
- **Jenkins** installed and running (with pipeline plugin)

---
## 🚀 How to run the repository

- Add **AWS access key** and **AWS secret key** to jenkins credentials.
- Edit ansible playbook to your repository in **Docker hub**.
- login your host machine to your **Docker hub** profile.
- Create a job in **Jenkins**.
- Run pipeline.
- you have 3 Choice **Apply, Destroy, None**
   - **Apply:** to create instance on AWS.
   - **Destroy:** to delete instance.
   - **None:** to cancel pipeline.

---

## 👨‍💻 Author

**Mohamed Al-Ghazali**

🔗 [LinkedIn](https://www.linkedin.com/in/mohamed-abdullah0180/)

🔗 [GitHub](https://github.com/Mohamed-Elghzaly/)

