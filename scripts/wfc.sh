docker run -it -v wwiv:/srv/wwiv -p 3636:2323 --name config -e "WWIV_MODE=wfc" wwiv:latest