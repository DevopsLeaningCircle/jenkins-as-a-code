#!groovy

import jenkins.model.*
import jenkins.security.plugins.ldap.*
import hudson.security.*

def instance = Jenkins.getInstance()
def ldapServer       = System.getenv("LDAP_SERVER") ?: "ldap://example.com"
def rootDN           = System.getenv("LDAP_ROOT_DN") ?: "dc=example,dc=com"
def userSearchBase   = System.getenv("LDAP_USER_SEARCH_BASE") ?: ""
def userSearchFilter = System.getenv("LDAP_USER_SEARCH_FILTER") ?: "uid={0}"
def managerDN        = System.getenv("LDAP_MANAGER_DN") ?: "cn=admin,dc=example,dc=com"
def managerPassword  = System.getenv("LDAP_MANAGER_PASSWORD") ?: ""

println "--> Configuring LDAP with server: ${ldapServer}"

SecurityRealm ldapRealm = new LDAPSecurityRealm(
    ldapServer,
    rootDN,
    userSearchBase,
    userSearchFilter,
    null, null,
    managerDN,
    managerPassword,
    false, false, null,
    null, null, null,
    null, null, null
)

instance.setSecurityRealm(ldapRealm)
instance.save()