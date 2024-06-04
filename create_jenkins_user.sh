echo "Waiting for Jenkins to start up..."
sleep 30

sudo wget http://localhost:8080/jnlpJars/jenkins-cli.jar

admin_password=`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`
sudo java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$admin_password groovy = < /tmp/InitJenkins.groovy $JENKINS_USERNAME $JENKINS_PASSWORD
echo "Jenkins user created successfully."
sudo systemctl restart jenkins
