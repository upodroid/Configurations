#!/bin/bash
#Jenkins HTTP Application Deployment from git repo

######## Build Job (Git Clone + GCS Push)

ls -alh
zip -r "artefacts--Build-$BUILD_ID.zip" *
ls -al | grep *.zip

######## Deployment Job 

# Install unzip + nginx + on the target server first
wget https://storage.googleapis.com/$bucketname/artefacts--Build-$buildno.zip

scp $WORKSPACE/artefacts--Build-$buildno.zip $targetmachine:/home/jenkins 
ssh $targetmachine << EOF
 sudo rm -rf /var/www/html
 sudo unzip artefacts--Build-$buildno.zip -d /var/www/html
 rm artefacts--Build-$buildno.zip
 sudo ls -al /var/www/html
 echo
 echo 'The ip address of the web server is' \$(dig +short myip.opendns.com @resolver1.opendns.com.)
 echo
 nc -z -v -w5 \$(dig +short myip.opendns.com @resolver1.opendns.com) 80
 if [ $? -eq 0 ]; then
	 echo
     curl -I localhost
 else
     echo Failed deployment
     exit 1
 fi
EOF

rm artefacts--Build-$buildno.zip
