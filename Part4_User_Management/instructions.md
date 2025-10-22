## Part4_User_Management/instructions.md

```markdown
# User Management

## Objective
To create a new user named `learnly` and configure appropriate file permissions.

## Steps Performed

### 1. Create New User
```bash
# Create user with home directory
sudo useradd -m learnly

# Set password for the user
sudo passwd learnly