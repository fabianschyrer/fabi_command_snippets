Jenkins Scripts


Jenkins.instance.pluginManager.plugins.sort { plugin.getShortName() }.each{
  plugin -> 
    println ("${plugin.getShortName()}:${plugin.getVersion()}")
}


Jenkins.instance.pluginManager.plugins.each{
  plugin -> 
    println ("${plugin.getShortName()}:${plugin.getVersion()}")
}





Jenkis OAuth Plugin
https://wiki.jenkins.io/display/JENKINS/Google+OAuth+Plugin

Jenkins HTTP request Plugin
https://wiki.jenkins.io/display/JENKINS/HTTP+Request+Plugin
https://github.com/jenkinsci/http-request-plugin
https://jenkins.io/doc/pipeline/steps/http_request/#httprequest-perform-an-http-request-and-return-a-response-object

https://www.openmakesoftware.com/restful-json-api-calls-jenkins-pipeline/
https://incognitjoe.github.io/rest-calls-in-jenkins-pipelines.html
http://cicd.life/making-http-api-calls-to-dockerhub-from-jenkinsfile/







du -a / | sort -n -r | head -n 100
du -hs * | sort -rh | head -n 100
du -Sh | sort -rh | head -n 100
find -type f -exec du -Sh {} + | sort -rh | head -n 100
find / -type f -exec du -Sh {} + | sort -rh | head -n 100
df
df -h
df -Th
du -sh *
du -xh / |grep '^\S*[0-9\.]\+G'|sort -rn
find / -printf '%s %p\n'| sort -nr | head -10




