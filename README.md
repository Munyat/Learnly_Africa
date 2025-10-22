# Learnly Africa - Linux Assessment

![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)
![WordPress](https://img.shields.io/badge/WordPress-%23117AC9.svg?style=for-the-badge&logo=WordPress&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

## 📋 Project Overview

This repository contains the complete Linux administration assessment for Learnly Africa, demonstrating proficiency in AWS EC2 management, SSH configuration, user administration, Bash scripting, and Docker containerization.

## 🏗️ Repository Structure

```
Learnly-Africa/
├── Linux_Assessment/          # Main assessment folder
│   ├── scripts/              # Bash scripts
│   │   └── install_docker.sh
│   ├── documentation/        # Setup instructions
│   │   └── Docker_commands.txt
│   └── screenshots/          # All assessment evidence
│       ├── aws_ec2/
│       │   └── EC2_instance.png
│       ├── bash_script/
│       │   └── Bash_script.png
│       ├── docker_wordpress/
│       │   └── docker_wordpress_setup.png
│       ├── script_execution/
│       │   └── script_execution.png
│       ├── ssh_access/
│       │   └── SSH_shell_prompt.png
│       └── user_management/
│           └── User_management.png
├── Part3_SSH_Customization/
│   └── instructions.md
├── Part4_User_Management/
│   └── instructions.md
├── Part5_Bash_Scripting/
│   └── instructions.md
└── README.md
```

## 🎯 Assessment Completion Evidence

### Part 2: AWS EC2 Setup ✅
**Screenshot:** [`Linux_Assessment/screenshots/aws_ec2/EC2_instance.png`](Linux_Assessment/screenshots/aws_ec2/EC2_instance.png)

- **Instance Name:** `learnly`
- **Environment:** AWS Lab 1 (Sandbox)
- **Status:** Running ✅
- **OS:** Ubuntu 22.04 LTS
- **Instance Type:** t2.micro

### Part 3: SSH Access and Shell Customization ✅
**Screenshot:** [`Linux_Assessment/screenshots/ssh_access/SSH_shell_prompt.png`](Linux_Assessment/screenshots/ssh_access/SSH_shell_prompt.png)

**Code Implementation:**
```bash
# SSH Connection to Ubuntu
ssh -i "learnly-key.pem" ubuntu@EC2_PUBLIC_IP

# Shell Prompt Customization
echo 'PS1="\u@\h:\w# "' >> ~/.bashrc
source ~/.bashrc
```

**Achievements:**
- ✅ Successful SSH connection to EC2 instance
- ✅ Shell prompt customized from `$` to `#`
- ✅ Persistent across sessions

### Part 4: User Management ✅
**Screenshot:** [`Linux_Assessment/screenshots/user_management/User_management.png`](Linux_Assessment/screenshots/user_management/User_management.png)

**Code Implementation:**
```bash
# User Creation on Ubuntu
sudo adduser learnly
# Follow prompts to set password and user information

# Alternative method with useradd
sudo useradd -m -s /bin/bash learnly
sudo passwd learnly

# Permission Configuration
sudo chown learnly:learnly /home/learnly
sudo chmod 755 /home/learnly

# User Switching
sudo su - learnly
```

**Achievements:**
- ✅ User `learnly` created successfully
- ✅ Home directory permissions configured (755)
- ✅ Full read, write, execute permissions granted
- ✅ Secure user isolation maintained

### Part 5: Bash Scripting and Docker Installation ✅
**Script Screenshot:** [`Linux_Assessment/screenshots/bash_script/Bash_script.png`](Linux_Assessment/screenshots/bash_script/Bash_script.png)
**Execution Screenshot:** [`Linux_Assessment/screenshots/script_execution/script_execution.png`](Linux_Assessment/screenshots/script_execution/script_execution.png)

## 🐋 Docker Installation Script for Ubuntu

**File:** [`Linux_Assessment/scripts/install_docker.sh`](Linux_Assessment/scripts/install_docker.sh)

```bash
#!/bin/bash

# Linux Assessment - Docker Installation Script for Ubuntu
# Author: Brian Kipkirui Cheruiyot
# Description: Automated Docker installation on Ubuntu AWS EC2

echo "=== Docker Installation Script for Ubuntu ==="
echo "Starting Docker installation process..."

# Update system packages
echo "[1/6] Updating system packages..."
sudo apt-get update -y
sudo apt-get upgrade -y

# Install prerequisites
echo "[2/6] Installing prerequisites..."
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
echo "[3/6] Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker repository
echo "[4/6] Adding Docker repository..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
echo "[5/6] Installing Docker Engine..."
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
echo "[6/6] Adding user to docker group..."
sudo usermod -aG docker $USER

# Verify installation
echo "Verifying Docker installation..."
docker --version

echo "=== Docker installation completed successfully! ==="
echo "Please log out and log back in for group changes to take effect."
echo "After re-login, verify with: docker run hello-world"
```

**Execution Commands:**
```bash
chmod +x install_docker.sh
./install_docker.sh
```

### Part 6: Docker Configuration and WordPress Deployment ✅
**Screenshot:** [`Linux_Assessment/screenshots/docker_wordpress/docker_wordpress_setup.png`](Linux_Assessment/screenshots/docker_wordpress/docker_wordpress_setup.png)

**Docker Commands Used:**
```bash
# Pull required images
docker pull mysql:5.7
docker pull wordpress:latest

# Create a network for containers
docker network create wordpress-network

# Run MySQL container
docker run -d --name mysql-db \
  --network wordpress-network \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_DATABASE=wordpress \
  -e MYSQL_USER=wordpress \
  -e MYSQL_PASSWORD=wordpress \
  -v mysql_data:/var/lib/mysql \
  mysql:5.7

# Run WordPress container
docker run -d --name wordpress-app \
  --network wordpress-network \
  -p 80:80 \
  -e WORDPRESS_DB_HOST=mysql-db \
  -e WORDPRESS_DB_USER=wordpress \
  -e WORDPRESS_DB_PASSWORD=wordpress \
  -e WORDPRESS_DB_NAME=wordpress \
  -v wordpress_data:/var/www/html \
  wordpress:latest
```

**Alternative using Docker Compose:**

**File:** `docker-compose.yml`
```yaml
version: '3.8'

services:
  db:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
    volumes:
      - db_data:/var/lib/mysql
    networks:
      - wordpress-network

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    restart: always
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wp_data:/var/www/html
    networks:
      - wordpress-network

volumes:
  db_data:
  wp_data:

networks:
  wordpress-network:
    driver: bridge
```

**Docker Compose Commands:**
```bash
# Install Docker Compose on Ubuntu
sudo apt-get install docker-compose -y

# Deploy with Docker Compose
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs
```

**Achievements:**
- ✅ Docker images successfully pulled
- ✅ MySQL container running with proper database setup
- ✅ WordPress container deployed and linked to MySQL
- ✅ WordPress accessible via EC2 Public IPv4 address
- ✅ WordPress setup page loaded successfully

## 🚀 Quick Start

### Prerequisites
- AWS Account with EC2 access
- SSH client on local machine
- Basic Linux command line knowledge

### Deployment Steps
1. **Launch EC2 Instance**
   - Use Ubuntu 22.04 LTS AMI
   - Configure security groups (SSH:22, HTTP:80)

2. **SSH into Instance**
   ```bash
   ssh -i "your-key.pem" ubuntu@your-ec2-ip
   ```

3. **Run Docker Installation**
   ```bash
   git clone https://github.com/briankipkirui/Learnly-Africa
   cd Learnly-Africa/Linux_Assessment/scripts
   chmod +x install_docker.sh
   ./install_docker.sh
   ```

4. **Deploy WordPress**
   ```bash
   # Log out and log back in after Docker installation
   exit
   ssh -i "your-key.pem" ubuntu@your-ec2-ip
   
   # Deploy WordPress and MySQL
   cd Learnly-Africa/Linux_Assessment/documentation
   # Execute Docker commands from Docker_commands.txt
   ```

## 📊 Technical Skills Demonstrated

- **Cloud Computing**: AWS EC2 instance management with Ubuntu
- **Linux Administration**: User management, permissions, shell customization on Ubuntu
- **Scripting**: Bash script automation for Ubuntu package management
- **Containerization**: Docker installation and container management
- **Web Services**: WordPress deployment and configuration
- **Security**: SSH key management, user permissions, Ubuntu security practices
- **Documentation**: Comprehensive project documentation

## 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| **AWS EC2** | Cloud infrastructure |
| **Ubuntu 22.04 LTS** | Operating system |
| **Docker** | Containerization platform |
| **WordPress** | Content management system |
| **MySQL** | Database management |
| **Bash** | Scripting and automation |
| **APT** | Ubuntu package management |

## 📝 Documentation

- [SSH Customization Instructions](Part3_SSH_Customization/instructions.md)
- [User Management Instructions](Part4_User_Management/instructions.md)
- [Bash Scripting Instructions](Part5_Bash_Scripting/instructions.md)
- [Docker Commands](Linux_Assessment/documentation/Docker_commands.txt)

## 🔧 Ubuntu-Specific Notes

- **Default User:** `ubuntu` (instead of `ec2-user` for Amazon Linux)
- **Package Manager:** `apt` (instead of `yum`)
- **Service Management:** `systemctl`
- **SSH Access:** Use `ubuntu` username for initial connection

## 👨‍💻 Author

**Brian Kipkirui Cheruiyot**  
📧 Email: [briankipkiruimunyat@gmail.com](mailto:briankipkiruimunyat@gmail.com)  
🔗 GitHub: [briankipkirui](https://github.com/briankipkirui)  
🏫 Institution: Learnly Africa  

## 📄 License

This project is for educational purposes as part of the Learnly Africa Linux Administration course.

---

<div align="center">

### 🎓 Learnly Africa Linux Assessment - Completed! ✅

*Ubuntu 22.04 LTS | AWS EC2 | Docker | WordPress | MySQL*

</div>