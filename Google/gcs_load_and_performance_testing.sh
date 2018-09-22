***** GCS - Load and Performance Testing *****

# create files on LNX machine (CLI)
dd if=/dev/zero of=output.dat  bs=10M  count=1
dd if=/dev/zero of=output.dat  bs=100M  count=1
dd if=/dev/zero of=output.dat  bs=250M  count=1
dd if=/dev/zero of=output.dat  bs=500M  count=1
dd if=/dev/zero of=output.dat  bs=1G  count=1

dd if=/dev/zero of=output.dat  bs=1M  count=10
dd if=/dev/zero of=output.dat  bs=1M  count=100
dd if=/dev/zero of=output.dat  bs=1M  count=250
dd if=/dev/zero of=output.dat  bs=1M  count=500
dd if=/dev/zero of=output.dat  bs=1M  count=1024

# upload files to GCS via gsutil
https://cloud.google.com/storage/docs/quickstart-gsutil
https://cloud.google.com/storage/docs/gsutil/commands/cp

# gsutil perfdiag
https://cloud.google.com/storage/docs/gsutil/commands/perfdiag
https://github.com/GoogleCloudPlatform/gsutil/blob/master/gslib/commands/perfdiag.py

# usefull information
https://medium.com/@duhroach/google-cloud-storage-performance-4cfcec8bad72
https://stackoverflow.com/questions/30336896/what-read-throughput-should-be-expected-out-of-google-cloud-storage-from-a-compu
https://cloudplatform.googleblog.com/2018/03/optimizing-your-Cloud-Storage-performance-Google-Cloud-Performance-Atlas.html

Filesize:								10MB, 100MB, 250MB, 500MB, 1GB
Number of runs:							10




