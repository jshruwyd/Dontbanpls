sudo apt update
sudo apt install tigervnc-standalone-server -y
sudo apt install openbox -y
sudo apt install firefox -y
wget -O a.tgz "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz"
tar -xf a.tgz
./ngrok config add-authtoken 2eaehnkTjyL4OmHHKgaCsGmTBEU_6QCyvFZNhdNgHQgNbNQ1g
sudo vncserver -xstartup "openbox" -SecurityType none -rfbport 6080
