#!/usr/bin/env groovy


String.metaClass.json = { new groovy.json.JsonSlurper().parseText(delegate) }
String.metaClass.xml = { new groovy.util.XmlSlurper().parseText(delegate) }

def ant = new groovy.util.AntBuilder()

def projects = [
    'cloudfoundry/cli':'cf_cli_version',
    'cloudfoundry/bosh-bootloader':'bosh_bootloader_version',
    'cloudfoundry/bosh-cli':'bosh_cli_version',
    'opencontrol/compliance-masonry':'compliance_masonry_version',
    'mikefarah/yaml':'yaml_linux_version',
    'hashicorp/terraform':'terraform_version'
]

projects.each { project, ansibleKey -> 
    def url = "https://github.com/${project}/releases.atom"
    println url
    def idString = url.toURL().text.xml().entry[0].id.text()
    def newVersion = idString.substring(idString.lastIndexOf('/') + 1).replace('v','')
    
    def ansible = new File('ansible/main.yml')
    def oldVersion = ansible.readLines().find{ it.contains(ansibleKey) }.replace("${ansibleKey}: ","").replace('"','').trim()
    println newVersion
    println oldVersion
    
    if (newVersion != oldVersion) {
        ant.replace(file: "ansible/main.yml", token: "${ansibleKey}: \"${oldVersion}\"", value: "${ansibleKey}: \"${newVersion}\"")
    }
}
