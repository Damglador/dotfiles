#!/bin/sh

hostname="$(uname -n)"

case "$hostname" in
  DamgladorPC)      echo 154 ;;
  Parasite)         echo 200 ;;
  ThinkCentre-E73)  echo 160 ;;
  Keenetic-8745)    echo 39  ;;
  *) "$(( 0x$(echo "$hostname" | md5sum | cut -c1-8) % 256 ))" ;;
esac
