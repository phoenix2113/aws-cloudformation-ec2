#!/usr/bin/env bash

usage="Usage: $(basename "$0") region stack-name [aws-cli-opts]
where:
  stack-name   - the stack name
  aws-cli-opts - extra options passed directly to create-stack/update-stack
"

if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$1" == "help" ] || [ "$1" == "usage" ] ; then
  echo "$usage"
  exit -1
fi

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "$usage"
  exit -1
fi
set -eu -o pipefail

echo "Checking if stack exists ..."

if ! aws cloudformation describe-stacks --region $1 --stack-name $2 ; then

  echo -e "\nStack does not exist, creating ..."
  aws --region $3 cloudformation create-stack --stack-name $1 --timeout-in-minute 15 $2\ 

  echo "Waiting for stack to be created ..."
  aws --region $3 cloudformation wait stack-create-complete --stack-name $1\

else

  echo -e "\nStack exists, attempting update ..."

  set +e
  update_output=$( aws --region $3 cloudformation update-stack --stack-name $1 $2)
  status=$?
  set -e

  echo "$update_output"

  if [ $status -ne 0 ] ; then
    echo $status
    # Don't fail for no-op update
    if {[ $update_output == *"ValidationError"* && $update_output == *"No updates"* ]] ; then
      echo -e "\nFinished create/update - no updates to be performed"
      exit 0
    else
      exit $status
    fi

  fi

  echo "Waiting for stack update to complete ..."
  aws cloudformation wait stack-update-complete \
    --region $3 \
    --stack-name $1 \

fi

echo "Finished create/update successfully!"