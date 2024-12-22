# MySQL Instance
resource "aws_instance" "mysql_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.private_subnet_id
  security_groups = [module.security_group.mysql_sg_id]

  user_data = <<-EOF
    #!/bin/bash
    # Update system and install Ansible dependencies
    sudo apt-get update -y
    sudo apt-get install -y python3 python3-pip
    sudo pip3 install boto3
  EOF

  tags = {
    Name = "MySQL-Instance"
  }
}

# Bastion Host Instance
resource "aws_instance" "bastion_host" {
  ami                        = var.ami
  instance_type              = var.instance_type
  key_name                   = var.key_name
  subnet_id                  = var.public_subnet_id
  security_groups            = [module.security_group.bastion_sg_id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash

    # Update system and install required packages
    sudo apt-get update -y
    sudo apt-get install -y python3 python3-pip awscli apache2
    sudo apt install php-mysqli -y
    sudo apt install mysql-client-core-8.0

    # Install Python packages
    sudo pip3 install boto3

    # Create /home/ubuntu directory if it does not exist
    sudo mkdir -p /home/ubuntu

    # Download the private key (jenkins.pem) from the presigned URL
    wget "https://ramratan-bucket-2510.s3.amazonaws.com/jenkins.pem?AWSAccessKeyId=AKIAZ3MGMYHMT6M3VUVM&Signature=eApwyOpugPZnjl1LgQy%2FUHMAdBg%3D&Expires=1734595756" -O /home/ubuntu/jenkins.pem

    # Set the appropriate permissions for the private key
    sudo chmod 400 /home/ubuntu/jenkins.pem

    # Change the ownership of jenkins.pem to ubuntu
    sudo chown ubuntu:ubuntu /home/ubuntu/jenkins.pem

    # Fetch the private IP of the MySQL instance dynamically
    MYSQL_IP=$(aws ec2 describe-instances \
        --instance-ids ${aws_instance.mysql_instance.id} \
        --query "Reservations[].Instances[].PrivateIpAddress" \
        --output text)

    # Create a PHP test page to verify MySQL connectivity
    echo "<?php phpinfo(); ?>" | sudo tee /var/www/html/index.php
    echo "<?php
    // Enable error reporting for debugging
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    // Start the session
    session_start();

    // Check if the user is logged in
    if (!isset(\$_SESSION['logged_in']) || \$_SESSION['logged_in'] !== true) {
        header('Location: login.php'); // Redirect to login page if not logged in
        exit();
    }

    // Database connection parameters
    \$servername = \"$MYSQL_IP\";
    \$username = \"web_user\";
    \$password = \"password\";
    \$database = \"employees\";

    // Create connection
    \$conn = new mysqli(\$servername, \$username, \$password, \$database);

    // Check connection
    if (\$conn->connect_error) {
        die(\"Connection failed: \" . \$conn->connect_error);
    }

    // Handle form submission to add employee
    if (\$_SERVER[\"REQUEST_METHOD\"] == \"POST\" && isset(\$_POST['add_employee'])) {
        // Sanitize and validate input data
        \$name = mysqli_real_escape_string(\$conn, \$_POST['name']);
        \$email = mysqli_real_escape_string(\$conn, \$_POST['email']);
        \$department = mysqli_real_escape_string(\$conn, \$_POST['department']);
        \$salary = mysqli_real_escape_string(\$conn, \$_POST['salary']);
        \$hire_date = mysqli_real_escape_string(\$conn, \$_POST['hire_date']);
        \$position = mysqli_real_escape_string(\$conn, \$_POST['position']);

        // Ensure all fields are provided
        if (empty(\$name) || empty(\$email) || empty(\$department) || empty(\$salary) || empty(\$hire_date) || empty(\$position)) {
            \$message = \"All fields are required!\";
        } else {
            // Prepare and bind
            \$sql = \"INSERT INTO employee_data (name, email, department, salary, hire_date, position) 
                    VALUES ('\$name', '\$email', '\$department', '\$salary', '\$hire_date', '\$position')\";

            if (\$conn->query(\$sql) === TRUE) {
                \$message = \"New employee added successfully.\";
            } else {
                \$message = \"Error: \" . \$conn->error;
            }
        }
    }

    // Handle employee deletion
    if (isset(\$_GET['delete_id'])) {
        \$delete_id = \$_GET['delete_id'];
        
        // Delete the employee record
        \$sql = \"DELETE FROM employee_data WHERE id = \$delete_id\";
        if (\$conn->query(\$sql) === TRUE) {
            \$message = \"Employee deleted successfully.\";
        } else {
            \$message = \"Error: \" . \$conn->error;
        }
    }

    // Fetch employee data from MySQL
    \$sql = \"SELECT id, name, email, department, salary, hire_date, position FROM employee_data\";
    \$result = \$conn->query(\$sql);
    ?>

    <!DOCTYPE html>
    <html lang=\"en\">
    <head>
        <meta charset=\"UTF-8\">
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
        <title>Add Employee</title>
    </head>
    <body>
        <h2>Welcome to Employee Management</h2>

        <!-- Add Employee Form -->
        <h3>Add Employee Details</h3>
        <?php if (isset(\$message)) { echo \"<p style='color: green;'>\$message</p>\"; } ?>
        <form method=\"POST\" action=\"\">
            <label for=\"name\">Name:</label><br>
            <input type=\"text\" id=\"name\" name=\"name\" required><br><br>
            <label for=\"email\">Email:</label><br>
            <input type=\"email\" id=\"email\" name=\"email\" required><br><br>
            <label for=\"department\">Department:</label><br>
            <input type=\"text\" id=\"department\" name=\"department\" required><br><br>
            <label for=\"salary\">Salary:</label><br>
            <input type=\"text\" id=\"salary\" name=\"salary\" required><br><br>
            <label for=\"hire_date\">Hire Date:</label><br>
            <input type=\"date\" id=\"hire_date\" name=\"hire_date\" required><br><br>
            <label for=\"position\">Position:</label><br>
            <input type=\"text\" id=\"position\" name=\"position\" required><br><br>
            <input type=\"submit\" name=\"add_employee\" value=\"Add Employee\">
        </form>

        <!-- Display Employees -->
        <h3>Employee List</h3>
        <table border=\"1\">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Department</th>
                <th>Salary</th>
                <th>Hire Date</th>
                <th>Position</th>
                <th>Actions</th>
            </tr>
            <?php
            if (\$result->num_rows > 0) {
                while(\$row = \$result->fetch_assoc()) {
                    echo \"<tr>\";
                    echo \"<td>\" . \$row['id'] . \"</td>\";
                    echo \"<td>\" . \$row['name'] . \"</td>\";
                    echo \"<td>\" . \$row['email'] . \"</td>\";
                    echo \"<td>\" . \$row['department'] . \"</td>\";
                    echo \"<td>\" . \$row['salary'] . \"</td>\";
                    echo \"<td>\" . \$row['hire_date'] . \"</td>\";
                    echo \"<td>\" . \$row['position'] . \"</td>\";
                    echo \"<td><a href='?delete_id=\" . \$row['id'] . \"'>Delete</a></td>\";
                    echo \"</tr>\";
                }
            } else {
                echo \"<tr><td colspan='8'>No employees found</td></tr>\";
            }
            ?>
        </table>
    </body>
    </html>
  EOF

  tags = {
    Name = "Bastion-Host"
  }
}
