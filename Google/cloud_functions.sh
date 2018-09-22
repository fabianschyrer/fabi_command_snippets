Google CloudFunctions

brew install python python@2
python2 --version
python3 --version
pip2 --version
pip3 --version
brew install pyenv-virtualenv
pip install --upgrade virtualenv
pip2 install --upgrade pip
pip2 install --upgrade virtualenv
pip2 install virtualenv
pip2 install virtualenvwrapper
pip3 install --upgrade virtualenv
pip3 install virtualenv
pip3 install virtualenvwrapper
cd /Users/fabianalexander/Documents/virtualenv/gcp-cloudfunctions-gcs-python-sample

virtualenv --python python3 env
source env/bin/activate
pip install google-cloud-storage
pip install --upgrade google-cloud
# deactivate

gcloud components update
gcloud components install beta
gsutil mb gs://fabian-cloudfunctions-test
git clone https://github.com/GoogleCloudPlatform/python-docs-samples.git
cd python-docs-samples/functions/gcs/

gcloud beta functions deploy hello_gcs_generic --runtime python37 --trigger-resource fabian-cloudfunctions-test --trigger-event google.storage.object.finalize

gcloud beta functions deploy hello_gcs_generic --runtime python37 --verbosity debug --trigger-resource fabian-cloudfunctions-test --trigger-event google.storage.object.finalize

gcloud beta functions deploy hello_gcs_fabian --runtime python37 --verbosity debug --trigger-resource fabian-cloudfunctions-test --trigger-event google.storage.object.finalize

gcloud beta functions deploy hello_gcs_fabian --runtime python36 --verbosity debug --trigger-resource fabian-cloudfunctions-test --trigger-event google.storage.object.finalize

gcloud beta functions deploy hello_gcs_fabian --region us-central1 --verbosity debug --runtime python37 --trigger-resource fabian-cloudfunctions-test --trigger-event google.storage.object.finalize

gcloud functions deploy hello_gcs_fabian --region us-central1 --verbosity debug --runtime python37 --trigger-resource fabian-cloudfunctions-test --trigger-event google.storage.object.finalize

# gcloud beta functions deploy hello_get --runtime python37 --trigger-http

bucket name:	fabian-cloudfunctions-test

touch gcf-test.txt
gsutil cp gcf-test.txt gs://fabian-cloudfunctions-test
gcloud functions logs read --limit 50

gcloud beta functions regions list
gcloud beta functions event-types list
gcloud beta functions logs read


FabianSchMacBookAir:gcs fabianalexander$ gcloud beta functions regions list
NAME
projects/<PROJECT>/locations/europe-west1
projects/<PROJECT>/locations/us-central1
projects/<PROJECT>/locations/us-east1
projects/<PROJECT>/locations/asia-northeast1

sudo pip uninstall pip

sudo rm -R /Library/Frameworks/Python.framework/
brew doctor
brew prune

rm '/usr/local/bin/2to3'
brew link --overwrite python


export CLOUDSDK_CORE_CHECK_GCE_METADATA=False


https://cloud.google.com/sdk/docs/uninstall-cloud-sdk
gcloud info --format='value(installation.sdk_root)'
/Users/fabianalexander/google-cloud-sdk
rm -R /Users/fabianalexander/google-cloud-sdk
gcloud info --format='value(config.paths.global_config_dir)'
/Users/fabianalexander/.gsutil
rm -R /Users/fabianalexander/.gsutil





