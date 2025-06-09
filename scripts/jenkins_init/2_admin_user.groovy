import hudson.security.*
import hudson.util.*;
import jenkins.install.*;
import jenkins.model.*

println ("Creating Jenkins Admin user...")

def props = new Properties()
def envFile = new File('/etc/jenkins.env')
if (envFile.exists()) {
    props.load(envFile.newDataInputStream())
} else {
    throw new RuntimeException("/etc/jenkins.env file not found")
}

def jenkinsUsername = props.getProperty('JENKINS_USERNAME')
def jenkinsPassword = props.getProperty('JENKINS_PASSWORD')

assert jenkinsUsername != null: "JENKINS_USERNAME env missing!"
assert jenkinsPassword != null: "JENKINS_PASSWORD env missing!"

def instance = Jenkins.getInstance()

instance.setInstallState(InstallState.INITIAL_SETUP_COMPLETED)

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(jenkinsUsername, jenkinsPassword)
instance.setSecurityRealm(hudsonRealm)
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)
instance.save()