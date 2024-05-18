sudo apt update
sudo apt install tigervnc-standalone-server firefox konsole openbox qemu-kvm -y
vncserver -xstartup "openbox"
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
sudo tar -xvzf ngrok-v3-stable-linux-amd64.tgz
./ngrok config add-authtoken 2B0ErkHwBmYm3HuSLRft3YlwoaZ_6yzB7XVg2SLfQs6fbXf2s
./ngrok tcp 5901
