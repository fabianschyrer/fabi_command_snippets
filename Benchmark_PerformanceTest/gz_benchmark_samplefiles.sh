GZ Benchmark samplefiles


dd if=/dev/zero of=sample_10MB.dat bs=1m count=10
dd if=/dev/zero of=sample_100MB.dat bs=1m count=100
dd if=/dev/zero of=sample_250MB.dat bs=1m count=250
dd if=/dev/zero of=sample_500MB.dat bs=1m count=500
dd if=/dev/zero of=sample_1GB.dat bs=1m count=1024


brew update

brew install p7zip

7z a -tgz  sample_10MB.gz /Users/fabianalexander/temp/sample_10MB\*
7z a -tgz  sample_100MB.gz /Users/fabianalexander/temp/sample_100MB\*
7z a -tgz  sample_250MB.gz /Users/fabianalexander/temp/sample_250MB\*
7z a -tgz  sample_500MB.gz /Users/fabianalexander/temp/sample_500MB\*
7z a -tgz  sample_1GB.gz /Users/fabianalexander/temp/sample_1GB\*


tar -czf  sample_10MB.gz /Users/fabianalexander/temp/sample_10MB\*
tar -czf  sample_100MB.gz /Users/fabianalexander/temp/sample_100MB\*
tar -czf  sample_250MB.gz /Users/fabianalexander/temp/sample_250MB\*
tar -czf  sample_500MB.gz /Users/fabianalexander/temp/sample_500MB\*
tar -czf  sample_1GB.gz /Users/fabianalexander/temp/sample_1GB\*






