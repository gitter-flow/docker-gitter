#!/bin/sh

curl -s \
  -d "client_id=api-social" \
  -d "client_secret=AzoICF0dvK8pfsJFto7Qso1AtA8ExWuB" \
  -d "grant_type=password" \
  -d "username=f" \
  -d "password=password" \
  -d "scope=openid" \
  "http://gitter.localhost/auth/realms/gitter/protocol/openid-connect/token" | jq .access_token
