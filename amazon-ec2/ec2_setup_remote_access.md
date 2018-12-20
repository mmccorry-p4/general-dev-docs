(Based off https://datawookie.netlify.com/blog/2017/08/remote-desktop-on-an-ubuntu-ec2-instance/)

## To access the Amazon EC2 server via SSH with X11 forwarding simply type (nothing to setup on server)

```bash
ssh -X scidb@SERVER_IP_ADDRESS
```

## Setting up an Amazon EC2 server for remote desktop access

Connect via SSH.

```bash
ssh username@SERVER_IP_ADDRESS
```

Install a few packages.

```
sudo apt update
sudo apt install -y ubuntu-desktop xrdp
```

Edit the RDP configuration file, `/etc/xrdp/xrdp.ini`, on the host. Note the entry for port, which will be important for making a connection. A minimal configuration might look like this:

```
[globals]
bitmap_cache=yes
bitmap_compression=yes
port=3389
crypt_level=low
channel_code=1
max_bpp=24

[xrdp1]
name=sesman-Xvnc
lib=libvnc.so
username=ask
password=ask
ip=127.0.0.1
port=ask-1
```

In the AWS Dashboard edit the Security Group for the EC2 instance and allow inbound TCP connections on port 3389.

Restart RDP.

```sudo service xrdp restart```

Choose the Window Manager for RDP connections. This involves changing the contents of a user’s `.xsession` file. You can copy the modified `.xsession` into `/etc/skel/` so that it will be propagated into any newly created accounts. However, you’ll need to copy it manually into existing accounts.

# Using XFCE as the window manager

```
sudo apt install -y xfce4 xfce4-goodies
echo xfce4-session >~/.xsession
```

N.B.
May need to add the following to your `~/.bashrc` file to allow for tab completion in the terminals in xfce
```
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi
```


## Acessing the remote desktop from ubuntu or windows

See https://datawookie.netlify.com/blog/2017/08/remote-desktop-on-an-ubuntu-ec2-instance/ for how to use vinagre to remote desktop (vnc) into the machine. (Don't run this from within a virtual machine as it runs into problems often.)

From Windows, simply use Remote Desktop (my preferred method if you guest OS is not Unix/Linux/Mac) and not a VNC client.

## If there are issues connecting to the server, you may need to run the following command on the host:
```
sudo iptables -A INPUT -p tcp --dport 5901 -j ACCEPT
```

