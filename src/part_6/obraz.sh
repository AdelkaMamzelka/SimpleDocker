#!/bin/bash

gcc -o web_server web_server.c -lfcgi
service nginx start
spawn-fcgi -p 8080 -n ./web_server
