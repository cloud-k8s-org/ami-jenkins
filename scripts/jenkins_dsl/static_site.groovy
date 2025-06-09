pipelineJob('static-site-job') {
    description('Pipeline job created using Job DSL that uses a Jenkinsfile from a Git repository')
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/cloud-k8s-org/static-site.git')
                        credentials('github-credential')
                    }
                    branches('main')
                }
            }
            scriptPath('Jenkinsfile')
        }
    }
    triggers {
        githubPush()
    }
}