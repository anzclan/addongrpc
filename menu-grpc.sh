#!/bin/bash
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[44;1;39m                 ⇱  GRPC  MENU  ⇲                    \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -e " $blue[•1]$NC Create Grpc Vless Vmess Accounts                                   "
echo -e " $blue[•2]$NC Delete Grpc Vless Vmess Accounts                                   "
echo -e " $blue[•3]$NC Renew XRay GRPC Accounts                                    "
echo -e " $blue[•4]$NC Cek Grpc Vless Vmess Accounts                         "
echo -e " $blue[•5]$NC Change Grpc Vless Vmess Accounts                                   "

echo ""
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
echo -e " $blue[•x]$NC Main Menu                                                        " 
echo ""                                                 
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" 
read -p "     Select From Options [1-10] :  " menu
case $menu in 
1) 
clear
addgrpc 
;;
2)
clear
delgrpc 
;;
3) 
clear
renewgrpc 
;;
4)
clear
 cekgrpc 
;;
5)
clear
port-grpc 
;;
00) 
clear
menu 
;;
*) 
clear
menu-grpc
esac