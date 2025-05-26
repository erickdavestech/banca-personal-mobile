allprojects {
    repositories {
        google()
        mavenCentral()

        maven {
            url = uri("https://developer.huawei.com/repo/")
        }

        maven {
            val props = java.util.Properties()
            val propsFile = rootProject.file("local.properties")
            if (propsFile.exists()) {
                props.load(propsFile.inputStream())
            }

            url = uri("https://facephicorp.jfrog.io/artifactory/maven-pro-fphi")
            credentials {
                username = props["artifactory.user"] as String? ?: System.getenv("USERNAME_ARTIFACTORY")
                password = props["artifactory.token"] as String? ?: System.getenv("TOKEN_ARTIFACTORY")
            }
        }
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
