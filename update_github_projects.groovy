#!/usr/bin/env groovy


String.metaClass.json = { new groovy.json.JsonSlurper().parseText(delegate) }
String.metaClass.xml = { new groovy.util.XmlSlurper().parseText(delegate) }

def ant = new groovy.util.AntBuilder()

def projects = [
    'cloudfoundry/cli':'cf_cli_version',
    'cloudfoundry/bosh-bootloader':'bosh_bootloader_version',
    'cloudfoundry/bosh-cli':'bosh_cli_version',
    'opencontrol/compliance-masonry':'compliance_masonry_version',
//    'mikefarah/yq':'yq_linux_version',
    'hashicorp/terraform':'terraform_version',
    'atom/atom':'atom_version',
    'docker/compose':'docker_compose_version',
    'golang/go':'go_version',
    'gradle/gradle':'gradle_version',
    'concourse/concourse':'fly_version'
]

projects.each { project, ansibleKey -> 
    def url = "https://github.com/${project}/releases.atom"
    def idString = url.toURL().text.xml().entry[0].id.text()
    def versionPrefix
    if ('golang/go'.equals(project)) {
        versionPrefix = 'go'
    } else {
        versionPrefix = 'v'
    }
    def newVersion = idString.substring(idString.lastIndexOf('/') + 1).replace(versionPrefix,'')

    if ('gradle/gradle'.equals(project)) {
        newVersion = formatGradleVersion(newVersion)
    }

    def ansible = new File('ansible/main.yml')
    def oldVersion = ansible.readLines().find{ it.contains(ansibleKey) }.replace("${ansibleKey}: ","").replace('"','').trim()

    if (newVersion != oldVersion && isSameMajorRelease(oldVersion, newVersion, project)
            && !newVersion.contains("beta") && !newVersion.toLowerCase().contains("rc")) {
	println "${url}: ${oldVersion} -> ${newVersion}"
        ant.replace(file: "ansible/main.yml", token: "${ansibleKey}: \"${oldVersion}\"", value: "${ansibleKey}: \"${newVersion}\"")
    }
}

def isSameMajorRelease (String oldVersion, String newVersion, String project) {
    if (getMajorVersion(oldVersion).equals(getMajorVersion(newVersion))) {
	return true
    }
    println "$project has changed major version from $oldVersion to $newVersion, skipping..."
    return false
}

def getMajorVersion (String version) {
    return version.substring(0, version.indexOf("."))
}

def formatGradleVersion (String version) {
    // if a new minor release comes out, the download link doesn't include the patch version
    if (version.endsWith(".0")) {
        return version.substring(0, version.size() - 2)
    }
}
