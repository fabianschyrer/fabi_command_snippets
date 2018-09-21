***** AWS SAM

git clone https://github.com/boto/boto3.git
cd boto3
virtualenv /Users/fabian/virtualenv/boto3
...
. /Users/fabian/virtualenv/boto3/bin/activate
pip install -r requirements.txt
pip install -e .


pip install -r requirements-docs.txt
cd docs
make html


npm install -g aws-sam-local
sam --version
npm update -g aws-sam-local


sam local start-lambda
python3 lambda_function.py




