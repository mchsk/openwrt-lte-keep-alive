#!/bin/ash
# Installation script.

install_netcat()
{
	echo "Installing netcat (opkg install netcat) ..."
    opkg -V0 update
    opkg -V0 install netcat
}

finish(){
	echo ""
    echo "NICE ;)"
    echo "There are 2 important steps to finish this setup:"
    echo ""
    echo "1. Make sure this line is in the cron. To open the cron editor, run: crontab -e"
    echo "   */2 * * * * $DIR/internet-keep-alive.sh"
    echo ""  
    echo "2. The interface representing the LTE connection is set to 'wwan'."
    echo "   To change the interface, please edit the line INTERFACE='wwan' in the 'restart-interface.sh'."
    echo ""
    echo "Enjoy!"

    rm install.sh
}

download_files()
{
	DIR=$( cd $(dirname $0) ; pwd -P )
	echo "Downloading files from https://github.com/mchsk/openwrt-lte-keep-alive ..."
    wget -q --no-check-certificate https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/master/dns-test.sh -O dns-test.sh && chmod +x dns-test.sh
    wget -q --no-check-certificate https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/master/internet-keep-alive.sh -O internet-keep-alive.sh && chmod +x internet-keep-alive.sh
    wget -q --no-check-certificate https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/master/restart-interface.sh -O restart-interface.sh && chmod +x restart-interface.sh
    wget -q --no-check-certificate https://raw.githubusercontent.com/mchsk/openwrt-lte-keep-alive/master/restart-router.sh -O restart-router.sh && chmod +x restart-router.sh
    finish
}

echo ""
echo "OpenWRT Keep-alive scripts."

while true; do
    read -p "This will install netcat as a prerequisite. Do you want to continue (y/n)? " yn
    case $yn in
        [Yy]* ) install_netcat; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer 'y' or 'n'.";;
    esac
done

echo ""
DIR=$( cd $(dirname $0) ; pwd -P )
while true; do
    read -p "This will download the files into $DIR. Do you want to continue (y/n)? " yn
    case $yn in
        [Yy]* ) download_files; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer 'y' or 'n'.";;
    esac
done



