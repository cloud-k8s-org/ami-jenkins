import hudson.security.*
import jenkins.model.*

def instance = Jenkins.getInstance()

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(args[0], args[1])
instance.setSecurityRealm(hudsonRealm)
instance.getSetupWizard().completeSetup()
instance.save()
/*def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.ADMINISTER, args[0])
instance.setAuthorizationStrategy(strategy)
instance.save()*/
