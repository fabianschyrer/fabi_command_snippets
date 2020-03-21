# Minishift

https://docs.okd.io/latest/minishift/getting-started/quickstart.html
https://blog.openshift.com/minishift-development-environment-node-js-openshift/
https://docs.openshift.com/online/dev_guide/application_lifecycle/new_app.html
https://blog.openshift.com/building-modern-distributed-applications-with-redis-enterprise-on-red-hat-openshift/

https://thenewstack.io/tutorial-blue-green-deployments-with-kubernetes-and-istio/

https://cloud.google.com/solutions/continuous-delivery-jenkins-kubernetes-engine

https://www.baeldung.com/spring-boot-deploy-openshift

https://github.com/siamaksade/openshift-cd-demo
https://github.com/nearform/minishift-demo
https://github.com/dockersamples/example-voting-app
https://github.com/subfuzion/voting-app
https://github.com/prgcont/demo-voting-app
https://github.com/mreferre/yelb


https://assets.openshift.com/hubfs/pdfs/DevOps_with_OpenShift.pdf?hsLang=en-us

https://developers.redhat.com/node/208105/

https://docs.okd.io/latest/dev_guide/deployments/how_deployments_work.html

https://github.com/openshift/origin
https://github.com/openshift/library


cat /proc/cpuinfo | grep processor | wc -l
4


sudo minishift start --vm-driver virtualbox --cpus 2 --memory 8192 --skip-registry-check=true --insecure-registry	


oc login -u developer -p developer
oc policy add-role-to-user registry-viewer developer
oc policy add-role-to-user registry-editor developer
$ docker login -u developer -p $(oc whoami -t) 172.30.1.1:5000
$ docker pull bitnami/nginx
$ docker tag bitnami/nginx 172.30.1.1:5000/myproject/nginx
$ docker push 172.30.1.1:5000/myproject/nginx












