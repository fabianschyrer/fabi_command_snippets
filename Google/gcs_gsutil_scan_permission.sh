gsutil ls gs://
gsutil ls -r gs://

gsutil ls gs://pub/**
gsutil ls -r gs://abc123 | sed 's/gs:\//https:\/\/storage.googleapis.com/'

gsutil ls -d -L gs://*

gsutil ls -count -recursive gs://bucket/folder

gsutil ls -l gs://*
gsutil ls -L gs://*


gsutil ls -L gs://<BUCKET_NAME>/generic-bigquery-exporter | grep -B 50 allUsers | grep gs://<BUCKET_NAME>/generic-bigquery-exporter



Cache-Control only applies to objects that are publicly accessible, because non-public data are not cacheable. Unless otherwise specified, the Cache-Control setting for publicly accessible objects is 3600 seconds.

{"entity": "allUsers", "role": "READER"}



gsutil ls -l -b -h -r gs://fabian-test-publiclink/*


 gsutil ls -l -b -h -R gs://fabian-test-publiclink/*



gsutil ls -l -b -h -R gs://fabian-test-publiclink/config | grep 


gsutil -h "Content-Type:*" \
	-h "Cache-Control:public" ls -h -l -R -L \
    gs://fabian-test-publiclink/config



gsutil acl get gs://fabian-test-publiclink/config

gsutil acl get -u AllUsers:R gs://fabian-test-publiclink/config



gsutil acl get gs://fabian-test-publiclink/config > acl.txt

gsutil -m acl get -R -a public-read gs://fabian-test-publiclink/config
gsutil -D getacl public-read gs://fabian-test-publiclink/config


gsutil help acl

gsutil ls gs://fabian-test-publiclink/config | sed 's/gs:\//https:\/\/storage.googleapis.com/'



gs://fabian-test-publiclink/config/local.json:
    Creation time:          Wed, 01 Aug 2018 09:52:06 GMT
    Update time:            Wed, 01 Aug 2018 09:53:04 GMT
    Storage class:          MULTI_REGIONAL
    Content-Length:         205
    Content-Type:           application/json
    Hash (crc32c):          SXJcCAWA==
    Hash (md5):             /5/JxsSQiYyq0TE/7Y5oUiMQ==
    ETag:                   CKim563Ky9YUwCEAI=
    Generation:             153311712645529832
    Metageneration:         2
    ACL:                    [
  {
    "entity": "project-owners-863016118673",
    "projectTeam": {
      "projectNumber": "863016118673",
      "team": "owners"
    },
    "role": "OWNER"
  },
  {
    "entity": "project-editors-863016118673",
    "projectTeam": {
      "projectNumber": "863016118673",
      "team": "editors"
    },
    "role": "OWNER"
  },
  {
    "entity": "project-viewers-863016118673",
    "projectTeam": {
      "projectNumber": "863016118673",
      "team": "viewers"
    },
    "role": "READER"
  },
  {
    "email": "fabian.sch@domain.com",
    "entity": "user-fabian.sch@domain.com",
    "role": "OWNER"
  },
  {
    "entity": "allUsers",
    "role": "READER"
  }
]





get a list of all files in all buckets
write file list to a single file
filter the file for ACL (allUsers:R)

get a list of all files in all buckets
use sed command to create URLS
try to access each URL and log to file if successfull

Example:
date --date="1 days ago" +"%Y%m%d" > yesterday
cat yesterday
gsutil du gs://<BUCKET_NAME> | grep json | grep $(cat yesterday) > raw/ttr.txt
gsutil du gs://<BUCKET_NAME> | grep json | grep $(cat yesterday) > raw/aws.txt

use thrid party solution
client and server
https://forsetisecurity.org/docs/latest/setup/install.html

use pub/sub to get notified on object changes
https://cloud.google.com/storage/docs/pubsub-notifications


gsutil ls -L gs://<BUCKET_NAME>/generic-bigquery-exporter | grep -B 50 allUsers | grep gs://<BUCKET_NAME>/generic-bigquery-exporter







