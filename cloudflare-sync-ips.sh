#!/bin/bash

CLOUDFLARE_FILE_PATH=${1:-/etc/nginx/cloudflare}

echo -e "# Cloudflare\n" > $CLOUDFLARE_FILE_PATH;

echo "# IPv4" >> $CLOUDFLARE_FILE_PATH;
for i in `curl -s -L https://www.cloudflare.com/ips-v4`; do
        echo "set_real_ip_from $i;" >> $CLOUDFLARE_FILE_PATH;
done

echo -e "\n# - IPv6" >> $CLOUDFLARE_FILE_PATH;
for i in `curl -s -L https://www.cloudflare.com/ips-v6`; do
        echo "set_real_ip_from $i;" >> $CLOUDFLARE_FILE_PATH;
done

echo -e "\nreal_ip_header cf-connecting-ip;" >> $CLOUDFLARE_FILE_PATH;

#test configuration and reload nginx
nginx -t && systemctl reload nginx
