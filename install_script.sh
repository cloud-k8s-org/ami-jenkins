sudo apt-get update
sudo apt-get upgrade -y

#Install Java
sudo add-apt-repository ppa:linuxuprising/java -y

sudo apt-get update

echo oracle-java17-installer shared/accepted-oracle-license-v1-3 select true | sudo debconf-set-selections
sudo apt-get install oracle-java17-installer -y
sudo apt-get install oracle-java17-set-default -y

# Install Jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y
sudo systemctl enable jenkins
