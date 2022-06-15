#!/bin/sh

curl -s \
  -d "client_id=api-social" \
  -d "client_secret=h8lCO4plzKFfsong2crbHl7y1fhCykpl" \
  -d "grant_type=password" \
  -d "username=pbarrie" \
  -d "password=password" \
  -d "scope=openid" \
  "http://gitter.localhost/auth/realms/gitter/protocol/openid-connect/token" | jq .access_token
