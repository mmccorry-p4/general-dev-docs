# This simple one-line script will map the current hostname of an EC2 instance
# to 127.0.0.1 in /etc/hosts to resolve various issues with resolving the hostname
# using sudo, java, etc.  Run once after an EC2 server is started with a new IP
# and therefore hostname

# Because amazon EC2 changes the hostname each time an instance is shutdown and started, need to edit the hosts file to have the current hostname resolve correctly

# Just executing the following command will produce an error like the following
# sudo ls
# sudo: unable to resolve host ip-272-35-25-12
# usename@ip-272-35-25-12:~$
# in this case ip-272-35-25-12 is the hostname that gets reset when the EC2 instance
# is stopped and started again with a new public-facing IP.  We don't run into
# problems usually using sudo commands, but we do in java and elsewhere when hostname
# errors pop up.

# We simply need to add this hostname to /etc/hosts to map to 127.0.0.1 with the following
sudo sh -c 'echo "127.0.0.1 $(hostname|cat) \n$(sudo cat /etc/hosts)" > /etc/hosts'

# (N.B. this will add a new line to /etc/hosts each time you run it...
# make sure to clean up old entries every once in a while. Only need to run it when
# the EC2 instance has be stopped and started (which gives it a new public-facing IP
# and corresponding hostname).  You can add it to a startup file, but adding it to
# ~/.bashrc will cause it to be run too often.)

