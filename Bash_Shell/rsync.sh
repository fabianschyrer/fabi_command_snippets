mount
/dev/disk2s1 on /Volumes/FSc_Stick_64gb_MacOSXext (hfs, local, nodev, nosuid, journaled, noowners)

diskutil list

diskutil info /dev/disk2s1

rsync -a src/ dest
rsync -a /Users/fabianalexander/ /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.[^.]* /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP

.ansible
.bash_history
.bash_profile
.bash_sessions
.bash_profile.backup
.bash_profile.pysave
.bash_profile_bak_20180703
.bash_profile_bak_20180709
.boto
.config
.docker
.gitconfig
.gitflow_export
.gitignore_global
.kube
.ssh
.vagrant.d
.viminfo
cli
Desktop
Documents
Downloads
google-cloud-sdk
PycharmProjects

rsync -avzP /Users/fabianalexander/.ansible /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.bash_history /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.bash_profile /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.bash_sessions /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.bash_profile.backup /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.bash_profile.pysave /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.bash_profile_bak_20180703 /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.bash_profile_bak_20180709 /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.boto /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.config /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.docker /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.gitconfig /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.gitflow_export /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.gitignore_global /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.kube /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.ssh /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.vagrant.d /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/.viminfo /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/cli /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/Desktop /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/Documents /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/Downloads /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/google-cloud-sdk /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP
rsync -avzP /Users/fabianalexander/PycharmProjects /Volumes/FSc_Stick_64gb_MacOSXext/BACKUP





















