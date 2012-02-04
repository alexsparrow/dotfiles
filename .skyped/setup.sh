#!/bin/sh
cp /etc/skyped/skyped.cnf .
openssl req -new -x509 -days 365 -nodes -config skyped.cnf -out skyped.cert.pem -keyout skyped.key.pem
