#!/usr/bin/env bash
SEP="==================="

confd -onetime -backend env

echo "Wrote dynamic dynamodb config..."
echo $SEP
cat /stockflare/dynamic-dynamodb.conf
echo $SEP

dynamic-dynamodb -c /stockflare/dynamic-dynamodb.conf -r $AWS_REGION
