#!/bin/sh
SERVER=git.allforone.mg
PORT=443
CERTIFICATE=/etc/gitlab-runner/certs/${SERVER}.crt
mkdir -p $(dirname "$CERTIFICATE")
openssl s_client -connect ${SERVER}:${PORT} -showcerts </dev/null 2>/dev/null | sed -e '/-----BEGIN/,/-----END/!d' |tee "$CERTIFICATE" >/dev/null
gitlab-runner register --tls-ca-file="$CERTIFICATE" --url="https://$SERVER" --token="glrt-dDoxCnU6MVZonv3DckweuFg2BWsbSy8Q.0w1jtpu5m"