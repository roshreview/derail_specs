#!/usr/bin/env bash

curl -s 127.0.0.1:3001 > /dev/null
curl 127.0.0.1:3001/reset-transaction
curl -X POST \
      -d '["test", { "name": "Test Name from Curl", "created_at": "2011-11-11 11:11:11" }]' \
      -H 'Content-Type: application/json' \
      127.0.0.1:3001/factory-bot/create
