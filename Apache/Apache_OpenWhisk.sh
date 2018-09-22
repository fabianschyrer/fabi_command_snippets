***** Apache OpenWhisk

https://openwhisk.apache.org

git clone https://github.com/apache/incubator-openwhisk-devtools.git
cd incubator-openwhisk-devtools/docker-compose
make quick-start
make hello-world
make destroy

brew update
brew install wsk
sudo mv /usr/local/Cellar/wsk/0.9.0-incubating/bin/wsk /usr/local/bin/wsk
wsk --help

wsk property set --apihost <API_HOST> --auth <AUTH_KEY> --namespace guest
Credentials are stored in ~/.wskprops
export WSK_CONFIG_FILE=<your-config-file>
wsk list

sudo mv /Users/fabian/openwhisk_wskdeploy-latest-mac-amd64/wskdeploy /usr/local/bin/wskdeploy
wskdeploy --help
wskdeploy -m manifest.yaml

sudo ln -s /Users/fabian/git/incubator-openwhisk/tools/admin/wskadmin /usr/local/bin/wskadmin

wsk property get --auth
whisk auth		23bc46b1-71f6-4ed5-8c54-816aa4f8c502:123zO3xZCLrMN6v2BKK1dXYFpXlPkccOFqm12CdAsMgRU4VrNZ9lyGVCGuMDGIwP