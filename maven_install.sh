#! /bin/bash

srpt=/etc/profile.d/maven.sh

function  Download_maven() {

        wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz --no-check-certificate -P /tmp
        tar -zxf /tmp/apache-maven-3.8.6-bin.tar.gz  -C /opt
}

function create_exec_script() {

        echo "Updating profile file"
        echo "export M2_HOME=/opt/apache-maven-3.8.6" >> ${srpt}
        echo "export PATH=/opt/apache-maven-3.8.6/bin:${PATH}" >> ${srpt}
        chmod +x /etc/profile.d/maven.sh
        echo "Applying new profile to update the current path"
        source /etc/profile.d/maven.sh

}

echo ">>>>>>>>>>>>>>>>>>>>>>This script is going to install maven<<<<<<<<<<<<<<<<<<<<<<"

echo "Checking maven existance"

mvn -version

if [ $? -eq  0 ]
then
   echo "maven is installed"

else
    echo "maven is not installed"
    echo "Cleaning up /tmp"
    rm -rf /tmp/apache*
    echo "deleting existing maven.sh"
    rm -rf /etc/profile.d/maven.sh
    echo "Deleting existing apache on /opt"
    rm -rf /opt/apache*

    Download_maven
    create_exec_script

fi
