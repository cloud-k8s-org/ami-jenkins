sudo wget https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.13.0/jenkins-plugin-manager-2.13.0.jar
echo "Installing plugins"
sudo java -jar jenkins-plugin-manager-2.13.0.jar --war /usr/share/java/jenkins.war --plugin-download-directory /var/lib/jenkins/plugins --plugin-file /tmp/JenkinsPlugins.txt
