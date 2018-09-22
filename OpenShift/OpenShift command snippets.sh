***** OpenShift *****

export PATH=$PATH:~/cli/openshift-origin-client-tools-v3.9.0-191fece-mac
	vi .bash_profile

oc login https://console.ocp.domain.com --token=w22qmzdXwKFVPe8VUpAsx!JdB5meNklOxkJJ2ZXyr-4Fas8

oc whoami
oc whoami --show-server
oc whoami --show-context

oc get projects
oc new-project myproject

oc adm policy add-role-to-user view developer -n myproject
oc config get-clusters
oc config get-contexts

oc get all -o name
oc describe route/blog-django-py
oc get all --selector app=blog-django-py -o name
oc get all --selector app=blog -o name
oc delete all --selector app=blog-django-py

oc new-app --search openshiftkatacoda/blog-django-py
oc new-app openshiftkatacoda/blog-django-py
oc expose service/blog-django-py
oc get route/blog-django-py
oc get imagestream -o name
oc describe imagestream/blog-django-py
oc delete all --selector app=blog-django-py
oc get all -o name
oc import-image openshiftkatacoda/blog-django-py --confirm
oc get all -o name
oc new-app blog-django-py --name blog-1
oc new-app <docker-image> --name <name>
oc new-app <image-stream> --name <name>
oc import-image <docker-image> --confirm

oc login -u developer -p developer
oc new-project myproject
oc get project
oc get all -o name
oc describe route/blog
oc get all --selector app=blog -o name
oc get all --selector app=forum -o name
oc delete all --selector app=blog
oc get all -o name

oc new-app python:latest~https://github.com/openshift-katacoda/blog-django-py --name blog
oc logs bc/blog --follow
oc status
oc expose service/blog
oc get route/blog
oc start-build blog
oc get builds --watch
oc describe bc/blog

git clone https://github.com/openshift-katacoda/blog-django-py
cd blog-django-py
echo 'BLOG_BANNER_COLOR=blue' >> .s2i/environment
oc start-build blog --from-dir=. --wait
oc start-build blog
oc cancel-build blog-4
oc get builds

oc new-app openshiftroadshow/parksmap-katacoda:1.0.0 --name parksmap
oc expose svc/parksmap
oc get all
oc get all -o name
oc get routes
oc get
oc types
oc describe route/parksmap
oc describe route parksmap
oc get route/parksmap -o json
oc get route/parksmap -o yaml
oc explain route.spec.host
oc edit route/parksmap
oc edit route/parksmap -o json

cat > parksmap-fqdn.json << !
{
    "kind": "Route",
    "apiVersion": "v1",
    "metadata": {
        "name": "parksmap-fqdn",
        "labels": {
            "app": "parksmap"
        }
    },
    "spec": {
        "host": "www.example.com",
        "to": {
            "kind": "Service",
            "name": "parksmap",
            "weight": 100
        },
        "port": {
            "targetPort": "8080-tcp"
        },
        "tls": {
            "termination": "edge",
            "insecureEdgeTerminationPolicy": "Allow"
        }
    }
}
!

oc create -f parksmap-fqdn.json
oc export route/parksmap -o json
oc get route/parksmap -o json

cat > parksmap-fqdn.json << !
{
    "kind": "Route",
    "apiVersion": "v1",
    "metadata": {
        "name": "parksmap-fqdn",
        "labels": {
            "app": "parksmap"
        }
    },
    "spec": {
        "host": "www.example.com",
        "to": {
            "kind": "Service",
            "name": "parksmap",
            "weight": 100
        },
        "port": {
            "targetPort": "8080-tcp"
        },
        "tls": {
            "termination": "edge",
            "insecureEdgeTerminationPolicy": "Redirect"
        }
    }
}
!

oc replace -f parksmap-fqdn.json
oc patch route/parksmap-fqdn --patch '{"spec":{"tls": {"insecureEdgeTerminationPolicy": "Allow"}}}'
oc get all -o name --selector app=parksmap
oc label service/parksmap web=true
oc get all -o name --selector web=true
oc export is,dc,svc,route --selector app=parksmap -o json --as-template=parksmap
oc label service/parksmap web-
oc delete route/parksmap-fqdn
oc delete route --selector app=parksmap
oc delete svc,route --selector app=parksmap
oc delete all --selector app=parksmap
oc delete all --all

oc new-app postgresql-ephemeral --name database --param DATABASE_SERVICE_NAME=database --param POSTGRESQL_DATABASE=sampledb --param POSTGRESQL_USER=username --param POSTGRESQL_PASSWORD=password
oc rollout status dc/database
oc get pods --selector app=database

POD=`oc get pods --selector app=database -o custom-columns=name:.metadata.name --no-headers`; echo $POD
oc rsh $POD
ps x
psql sampledb username
\q
exit

oc port-forward $POD 15432:5432 &
jobs
psql sampledb username --host=127.0.0.1 --port=15432
\q
kill %1
jobs

oc new-app openshiftkatacoda/blog-django-py --name blog
oc expose svc/blog
oc rollout status dc/blog

oc get pods --selector app=blog
oc get pods --selector app=blog -o jsonpath='{.items[?(@.status.phase=="Running")].metadata.name}'
pod() { local selector=$1; local query='?(@.status.phase=="Running")'; oc get pods --selector $selector -o jsonpath="{.items[$query].metadata.name}"; }
POD=`pod app=blog`; echo $POD

oc rsh $POD
ls -las
pwd
exit

oc rsync $POD:/opt/app-root/src/db.sqlite3 .
ls -las
oc rsync $POD:/opt/app-root/src/media .
mkdir uploads
oc rsync $POD:/opt/app-root/src/media/. uploads

curl --head http://blog-myproject.2886795290-80-simba02.environments.katacoda.com/robots.txt
cat robots.txt
oc rsync . $POD:/opt/app-root/src/htdocs --exclude=* --include=robots.txt --no-perms

curl http://blog-myproject.2886795290-80-simba02.environments.katacoda.com/robots.txt
oc rsync . $POD:/opt/app-root/src/htdocs --no-perms

git clone https://github.com/openshift-katacoda/blog-django-py
oc rsync blog-django-py/. $POD:/opt/app-root/src --no-perms --watch &
jobs
echo "BLOG_BANNER_COLOR = 'blue'" >> blog-django-py/blog/context_processors.py
oc rsh $POD kill -HUP 1
oc set env dc/blog MOD_WSGI_RELOAD_ON_CHANGES=1
oc rollout status dc/blog
POD=`pod app=blog`; echo $POD
jobs
kill -9 %1
jobs

oc rsync blog-django-py/. $POD:/opt/app-root/src --no-perms --watch &
echo "BLOG_BANNER_COLOR = 'green'" >> blog-django-py/blog/context_processors.py
kill -9 %1

oc run dummy --image centos/httpd-24-centos7
oc rollout status dc/dummy
oc get all --selector run=dummy -o name
oc set volume dc/dummy --add --name=tmp-mount --claim-name=data --type pvc --claim-size=1G --mount-path /mnt
oc rollout status dc/dummy
oc get pvc
POD=`pod run=dummy`; echo $POD
oc rsync ./ $POD:/mnt --strategy=tar
oc rsh $POD ls -las /mnt
oc set volume dc/dummy --remove --name=tmp-mount
oc rollout status dc/dummy
POD=`pod run=dummy`; echo $POD
oc rsh $POD ls -las /mnt
oc set volume dc/dummy --add --name=tmp-mount --claim-name=data --mount-path /mnt
oc rollout status dc/dummy
POD=`pod run=dummy`; echo $POD
oc rsh $POD ls -las /mnt

oc delete all --selector run=dummy
oc get all --selector run=dummy -o name
oc get pvc

oc login -u system:admin
cd ~/.kube/
oc get pods -n openshift-infra
oc get all -n openshift-infra

oc login -u developer -p developer
oc new-project myproject
oc new-app kubernetes/guestbook

oc login -u system:admin
oc adm top pod --heapster-namespace='openshift-infra'  --heapster-scheme="https" -n myproject
oc adm top pod -n myproject (For new OpenShift versions)

oc login -u developer -p developer
oc patch dc/guestbook -p '{"spec":{"template":{"spec":{"containers":[{"name":"guestbook","resources":{"limits":{"cpu":"80m"}}}]}}}}'
oc autoscale dc/guestbook --min 1 --max 3 --cpu-percent=20
oc get hpa guestbook -o yaml -n myproject
oc patch hpa/guestbook -p '{"spec":{"maxReplicas": 2}}' -n myproject
oc get events

seq 3 | xargs -0 -n1 timeout -t 60 md5sum /dev/zero (generate CPU load)
oc get pods
oc get events -w



oc new-build --strategy=docker --name simple-http-server --code https://github.com/openshift-katacoda/simple-http-server

oc new-build --strategy=docker --name python-wheelhouse --code https://github.com/openshift-katacoda/python-wheelhouse






