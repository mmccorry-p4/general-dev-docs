# This simple one-line script will map the current hostname of an EC2 instance
# to 127.0.0.1 in /etc/hosts to resolve various issues with resolving the hostname
# using java, spark, etc.  Should only need to RUN ONCE after an EC2 server is
# first started with a new hostname.

# Just executing the following command will produce an error like the following
# sudo ls
# sudo: unable to resolve host ip-272-35-25-12
# usename@ip-272-35-25-12:~$
# in this case ip-272-35-25-12 is the hostname.
# We don't run into problems usually using sudo commands,
# but we do in java and elsewhere when hostname errors pop up.

# We simply need to add this hostname to /etc/hosts to map to 127.0.0.1 with the following
sudo sh -c 'echo "127.0.0.1 $(hostname|cat) \n$(sudo cat /etc/hosts)" > /etc/hosts'

# (N.B. this will add a new line to /etc/hosts each time you run it...
# make sure to clean up old entries every once in a while. Should only need to run
# it ONCE unless the hostname has changed when the EC2 instance has be stopped and
# started (which gives it a new public-facing IP, but hostname rarely changes)
# You shouldn't need to add it to a startup file, and do not add it to ~/.bashrc
# will cause it to be run too often.)


