***** AWS RDK


fabians-MacBook-Pro:example_ci fabian$ pip install rdk
Collecting rdk
  Downloading https://files.pythonhosted.org/packages/7d/cf/c561f978f9d6a57e4ed48d468daada05a121c46df85cbe2ddb3909146fb5/rdk-0.3.30.tar.gz (144kB)
    100% |████████████████████████████████| 153kB 2.4MB/s 
Requirement already satisfied: boto3 in /usr/local/lib/python2.7/site-packages (from rdk) (1.9.6)
Collecting mock (from rdk)
  Downloading https://files.pythonhosted.org/packages/e6/35/f187bdf23be87092bd0f1200d43d23076cee4d0dec109f195173fd3ebc79/mock-2.0.0-py2.py3-none-any.whl (56kB)
    100% |████████████████████████████████| 61kB 7.8MB/s 
Requirement already satisfied: future in /usr/local/lib/python2.7/site-packages (from rdk) (0.16.0)
Requirement already satisfied: s3transfer<0.2.0,>=0.1.10 in /usr/local/lib/python2.7/site-packages (from boto3->rdk) (0.1.13)
Requirement already satisfied: jmespath<1.0.0,>=0.7.1 in /usr/local/lib/python2.7/site-packages (from boto3->rdk) (0.9.3)
Requirement already satisfied: botocore<1.13.0,>=1.12.6 in /usr/local/lib/python2.7/site-packages (from boto3->rdk) (1.12.6)
Requirement already satisfied: pbr>=0.11 in /usr/local/lib/python2.7/site-packages (from mock->rdk) (4.2.0)
Collecting funcsigs>=1; python_version < "3.3" (from mock->rdk)
  Using cached https://files.pythonhosted.org/packages/69/cb/f5be453359271714c01b9bd06126eaf2e368f1fddfff30818754b5ac2328/funcsigs-1.0.2-py2.py3-none-any.whl
Requirement already satisfied: six>=1.9 in /usr/local/lib/python2.7/site-packages (from mock->rdk) (1.11.0)
Requirement already satisfied: futures<4.0.0,>=2.2.0; python_version == "2.6" or python_version == "2.7" in /usr/local/lib/python2.7/site-packages (from s3transfer<0.2.0,>=0.1.10->boto3->rdk) (3.2.0)
Requirement already satisfied: urllib3<1.24,>=1.20 in /usr/local/lib/python2.7/site-packages (from botocore<1.13.0,>=1.12.6->boto3->rdk) (1.23)
Requirement already satisfied: python-dateutil<3.0.0,>=2.1; python_version >= "2.7" in /usr/local/lib/python2.7/site-packages (from botocore<1.13.0,>=1.12.6->boto3->rdk) (2.7.3)
Requirement already satisfied: docutils>=0.10 in /usr/local/lib/python2.7/site-packages (from botocore<1.13.0,>=1.12.6->boto3->rdk) (0.14)
Building wheels for collected packages: rdk
  Running setup.py bdist_wheel for rdk ... done
  Stored in directory: /Users/fabian/Library/Caches/pip/wheels/58/e1/0c/278d8f8dba87f38648cce0767d96c4eb2577a24ecca80bfc5a
Successfully built rdk
Installing collected packages: funcsigs, mock, rdk
Successfully installed funcsigs-1.0.2 mock-2.0.0 rdk-0.3.30
fabians-MacBook-Pro:example_ci fabian$ 


fabians-MacBook-Pro:example_ci fabian$ rdk
usage: rdk [-h] [-p PROFILE] [-k ACCESS_KEY_ID] [-s SECRET_ACCESS_KEY]
           [-r REGION] [-v]
           <command> ...
rdk: error: too few arguments
fabians-MacBook-Pro:example_ci fabian$ 


fabians-MacBook-Pro:example_ci fabian$ rdk init
Running init!
Creating Config bucket config-bucket-627443353872
Creating IAM role config-role
Waiting for IAM role to propagate
Creating delivery channel to bucket config-bucket-627443353872
Config Service is ON
Config setup complete.
Creating Code bucket config-rule-code-bucket-627443353872-ap-southeast-1
fabians-MacBook-Pro:example_ci fabian$ 



