#!/bin/bash

cp /etc/fstab /etc/fstab.bak

cat /etc/fstab | grep "/mnt/storage" > /dev/null
if [ $? -eq 0 ] ; then
  log "NFS storage already configured on fstab. Skipping..."
else
  mkdir -p /mnt/storage
  chown emichon:emichon /mnt/storage
  echo "
# NFS sur raspberry-trasnmission
192.168.0.5:/mnt/storage  /mnt/storage  nfs defaults,user,noauto  0 0" >> /etc/fstab
fi

cat /etc/fstab | grep "/mnt/freebox" > /dev/null
if [ $? -eq 0 ] ; then
  log "Freebox CIFS already configured on fstab. Skipping..."
else
  mkdir -p /mnt/freebox
  echo "
# Freebox
//mafreebox.freebox.fr/Disque\040dur/ /mnt/freebox cifs guest,uid=1020,gid=1023,rw,_netdev,file_mode=022 0 0" >> /etc/fstab
fi

success "fstab configured"

