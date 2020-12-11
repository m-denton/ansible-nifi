https://community.cloudera.com/t5/Community-Articles/Securing-NiFi-Step-by-Step/ta-p/244315

1) create valid certs
2) place the ca, client and server cert on the server and use the keytool to make the truststore
    y| keytool -import -file cacert.pem -alias cacert -keystore truststore.jks -storepass {server_fqdn}!
3) save truststore.jks to repo and place on servers with ansible

scp ~/Downloads/cacert.pem ec2-user@3.87.3.149:/tmp


Place .pfx on server and run the following:
openssl pkcs12 -in {cert-name}.pfx -nocerts -out key.pem -nodes
openssl pkcs12 -in {cert-name}.pfx -nokeys -out {ansible-fqdn}.crt
openssl rsa -in key.pem -out {ansible-fqdn}.key
openssl x509 -in vm0dncompla0001.corp.chartercom.com.crt -text -noout #grab CN and other info from crt

keytool -list -v -keystore UAT-vm0dncompla0001.corp.chartercom.com.pfx
keytool -importkeystore -srckeystore UAT-vm0dncompla0001.corp.chartercom.com.pfx -srcstoretype pkcs12 -srcalias nifi-key -destkeystore keystore.jks -deststoretype jks -destalias nifi-key
keytool -importcert -alias nifi-cert -file cacert.pem -keystore truststore.jks

        "ansible_fqdn": "vm0dncompla0001.corp.chartercom.com",
        "ansible_hostname": "vm0dncompla0001",

        vm0uncompla0002!

todo:
we had to do the following in order for ansible-pull to work with bitbucket:
mkdir /apps/infogov/tmp
export TMPDIR=/apps/infogov/tmp

let's see if this can be performed with adjusting remote_tmp and local_tmp in ansible.cfg #https://raw.githubusercontent.com/ansible/ansible/devel/examples/ansible.cfg




Setup script:
set repos
install ansible and git
make necessary dirs (/apps/infogov/tmp, /apps/infogov/.ssh)
place ssh keys (/apps/.ssh/id_rsa|id_rsa.pub) and chmod/chown them
git config --global ssh.variant ssh
ssh-keyscan -H bitbucket.corp.chartercom.com >> ~/.ssh/known_hosts

make keystore/truststore?