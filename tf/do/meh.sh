#!/bin/bash

set -exfu
mkdir ~/tmp
cd ~/tmp

k3stoken=
rm -f ~root/.k3s-token

tskey=
rm -f ~root/.tskey

echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqGiNI0Co9JAKytfce4UVhEJj+HMaoZ7TFiLg8SBeRDxV+OLma9rqDVkVqrxW5rkGMco3/Xhm/uGu+rkODJD/aZD/1fpzEsNUQIKhP9VXlVx98CMYOMCXTrgXZGdNPs0CzIb0TDI3W1tOGAA0VOZL+DGb/pUFiWeADLA9GiA8qnhahQp6yCNf8zpt3ATawSOGDLttB+PQPvwwUGMozihCcn84Kbf2Q0aQEl5J0kPLQTgBTJ1pPjTqBmkBWhP1KKAEDz3ziUmFF2eoZax7B+VXYlI6nPeETqFWkke6/EVLRqOXC4nYXKUbX2HloiEGkv4ifzzuGyS2Tdiysx0dthVcv cardno:8 624 146 > authorized_keys
install -m 0600 -o ubuntu -g ubuntu authorized_keys ~ubuntu/.ssh/authorized_keys
rm -f authorized_keys

echo FROM quay.io/defn/dev:k3d > Dockerfile
echo ENV DEFN_DEV_TSKEY=${tskey} >> Dockerfile
docker build -t k3d-control .
rm -f Dockerfile

k3d node create meh --role agent --image k3d-control --cluster https://100.106.117.83:6443 --token "${k3stoken}"
