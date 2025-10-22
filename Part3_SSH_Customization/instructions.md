# SSH Access and Shell Customization

## Objective
To establish SSH connection to AWS EC2 instance and customize the shell prompt from `$` to `#`.

## Steps Performed

### 1. SSH Connection to EC2 Instance
```bash
ssh -i "learnly-key.pem" ec2-user@YOUR_EC2_PUBLIC_IP