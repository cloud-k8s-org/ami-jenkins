import jenkins.*
import hudson.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import hudson.plugins.sshslaves.*
import hudson.model.*
import jenkins.model.*
import hudson.security.*

println "Installing Plugins..."

def instance = Jenkins.getInstance()

def PLUGIN_FILE_PATH = '/var/lib/jenkins/init.groovy.d/JenkinsPlugins.txt'

def REQUIRED_PLUGINS = new File(PLUGIN_FILE_PATH)
        .readLines()
        .collect { it.trim() }
        .findAll { it && !it.startsWith("#") }

println "Plugins to check/install: ${REQUIRED_PLUGINS}"

def installedPlugins = instance.pluginManager.plugins.collect { it.shortName }

def missingPlugins = REQUIRED_PLUGINS.findAll { !installedPlugins.contains(it) }

if (missingPlugins) {
    println "Missing plugins: ${missingPlugins}. Installing now..."
    missingPlugins.collect {
        def plugin = instance.updateCenter.getPlugin(it)
        if (plugin) {
            println "Installing plugin: ${it}"
            plugin.deploy().get()
        } else {
            println "WARNING: Plugin '${it}' not found in update center."
        }
    }

    println "Restarting Jenkins to apply plugin installations..."
    instance.restart()
    return
} else {
    println "All required plugins are already installed."
}
