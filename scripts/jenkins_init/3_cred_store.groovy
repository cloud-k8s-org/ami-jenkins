import jenkins.model.Jenkins
import com.cloudbees.plugins.credentials.domains.Domain
import com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl
import com.cloudbees.plugins.credentials.CredentialsScope
import java.util.Properties
import java.io.File


def instance = Jenkins.instance
def store = instance.getExtensionList("com.cloudbees.plugins.credentials.SystemCredentialsProvider")[0].getStore()


def props = new Properties()
def envFile = new File('/etc/jenkins.env')
if (envFile.exists()) {
    props.load(envFile.newDataInputStream())
} else {
    throw new RuntimeException("/etc/jenkins.env file not found")
}

def dockerUsername = props.getProperty("DOCKER_USERNAME")
def dockerPassword = props.getProperty("DOCKER_PASSWORD")
def githubUsername = props.getProperty("GIT_USERNAME")
def githubPassword = props.getProperty("GIT_PASSWORD")

def dockerCredentials = new UsernamePasswordCredentialsImpl(
        CredentialsScope.GLOBAL,
        "docker-credential",
        "Docker Credentials",
        dockerUsername,
        dockerPassword
)


def githubCredentials = new UsernamePasswordCredentialsImpl(
        CredentialsScope.GLOBAL,
        "github-credential",
        "GitHub Credentials",
        githubUsername,
        githubPassword
)

def domain = Domain.global()
store.addCredentials(domain, dockerCredentials)
store.addCredentials(domain, githubCredentials)