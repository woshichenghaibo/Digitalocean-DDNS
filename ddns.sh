#!/bin/bash

# 替换为你的DigitalOcean个人访问令牌
DIGITALOCEAN_TOKEN="YOUR_DIGITALOCEAN_TOKEN"
DOMAIN_NAME="domain.com"
SUB_DOMAIN="sub"
RECORD_TYPE="CNAME"
CURRENT_IP=$(ip -6 addr show scope global | grep inet6 | awk '{print $2}' | cut -d/ -f1)

# 查询现有CNAME记录
EXISTING_RECORD=$(curl -s -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
  "https://api.digitalocean.com/v2/domains/$DOMAIN_NAME/records?name=$SUB_DOMAIN.$DOMAIN_NAME&type=$RECORD_TYPE" \
  | jq -r '.domain_records[0].data')

if [ "$CURRENT_IP" != "$EXISTING_RECORD" ]; then
  echo "IP address has changed. Updating CNAME record..."

  # 构造更新数据
  UPDATE_DATA='{"data":"'"$CURRENT_IP"'"}'

  # 更新CNAME记录
  curl -s -X PUT \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
    -d "$UPDATE_DATA" \
    "https://api.digitalocean.com/v2/domains/$DOMAIN_NAME/records?name=$SUB_DOMAIN.$DOMAIN_NAME&type=$RECORD_TYPE"

  echo "CNAME record successfully updated to $CURRENT_IP."
else
  echo "IP address is up-to-date. No action needed."
fi
