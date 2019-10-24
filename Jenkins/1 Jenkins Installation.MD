# Jenkins Installation on Centos 

# Install java-1.8.0-openjdk-devel
```sh
sudo yum install -y java-1.8.0-openjdk-devel
```

# Install the repo and key, and then install Jenkins
```sh
 sh sudo yum install -y wget
```
# Download the repo.
```sh
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
```
# Import the required key.
```sh
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
```
# Install Jenkins.
sudo yum install -y jenkins
```

# Building in Jenkins

# Create a folder named Test
```sh
 In the dashboard click on create item, from there enter "Test" at the top of the page and then click "folder" and then "ok"
```

 # Create a user test job that saves it output in a file "user_test.txt"
```sh
- In the folder you created, go to new item on the left, then name the item user_test and then click **"freestyle build"** and then **"ok"** 

- In the job configuration page in the build step, click **execute shell**, then in the text box type **uname -a && whoami > user_test.txt** then click **save**.

- Then click **build** on the left, Then click **workspace** and locate the file, view the contets of the file by clicking view on the page. This should result in the username 'jenkins'

# Building from SCM

## Configure Maven Installer

- Navigate to Manage Jenkins and then Global Tool Configuration. Scroll down to Maven Installations.


The Maven installation should be named "M3".

Create a new Maven installation and set it to install automatically.

# Configure the Build to Use Maven and Make the Index File

 - Create a new Freestlye Project called "mavenproject".

 - Update the source code management to use the git repository provided https://github.com/sforcloud/devops-heloworld.git 

 - Add and configure a build step for top-level Maven components.

 - Configure M3 as the Maven server and set the Goals to "clean package".

 - Configure a build step to run the following go command:

  ```sh
   clean package install 
  ```

  - Add a post-build step to archive the artifacts.
