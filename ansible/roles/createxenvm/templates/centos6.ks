# Kickstart file automatically generated by anaconda.

#version=DEVEL
install
cdrom
lang en_US.UTF-8
keyboard us
network --onboot yes --device eth0 --bootproto dhcp --noipv6
rootpw xenroot
user --name=xenbuilder --password=xenroot --plaintext --homedir=/usr/src/xenbuilder --gecos="xenbuilder" --shell=/bin/bash --groups=user,wheel
firewall --service=ssh
authconfig --enableshadow --passalgo=sha512
selinux --enforcing
timezone --utc America/New_York
bootloader --location=mbr --driveorder=xvda,xvdb --append="crashkernel=auto console=hvc0 rhgb quiet"


# The following is the partition information you requested
# Note that any partitions you deleted are not expressed
# here so unless you clear all partitions first, this is
# not guaranteed to work
zerombr
clearpart --linux --drives=xvda
part /boot --fstype=ext3 --size=500 --asprimary
part / --fstype=ext4 --grow --size=1024 --asprimary
bootloader --timeout=5 --driveorder=xvda --append="console=hvc0"

#repo --name="CentOS"  --baseurl=cdrom:xvdd --cost=100

%packages --nobase
@core
@Development Tools
httpd
%end

%post
chkconfig httpd on
su - xenbuilder -c 'mkdir -p ~xenbuilder/.ssh'

# register public key 
cat <<EOF >> ~xenbuilder/.ssh/authorized_keys
{{ key.stdout }}
EOF
chown xenbuilder:xenbuilder ~xenbuilder/.ssh/authorized_keys
chmod -R go-rwx ~xenbuilder/.ssh 

# defaults speed up ssh connection
cat <<EOF > /etc/ssh/sshd_config
Protocol 2
SyslogFacility AUTHPRIV
PasswordAuthentication yes
ChallengeResponseAuthentication no
KerberosAuthentication no
KerberosOrLocalPasswd no
KerberosTicketCleanup no
KerberosGetAFSToken no
KerberosUseKuserok no
GSSAPIAuthentication no
GSSAPIAuthentication no
GSSAPICleanupCredentials no
GSSAPICleanupCredentials no
GSSAPIStrictAcceptorCheck no
GSSAPIKeyExchange no
UsePAM yes
AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS
X11Forwarding yes
UseDNS no
Subsystem       sftp    /usr/libexec/openssh/sftp-server
EOF

# enable sudo without asking for password for users of the group wheel
sed -i -e 's/# \(%wheel.*NOPASSWD.*\)/\1/g'  /etc/sudoers

%end

reboot
