import javaposse.jobdsl.dsl.DslScriptLoader
import javaposse.jobdsl.plugin.JenkinsJobManagement

def workspace = new File('.')
def jobManagement = new JenkinsJobManagement(System.out, [:], workspace)

def jobDslScript = new File('/var/lib/jenkins/dsl_scripts/static_site.groovy')
new DslScriptLoader(jobManagement).runScript(jobDslScript.text)
