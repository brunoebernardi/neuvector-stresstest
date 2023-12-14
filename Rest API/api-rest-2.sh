#!/bin/bash

DATE=$(date +%Y-%m-%d)

#Generate a stress task in controllers

#NeuVector ENV
_controllerIP_="" 
_controllerRESTAPIPort_="" #NodePort
_neuvectorUsername_="admin"
_neuvectorPassword_=""


#The snippet below will perform various system queries in NeuVector, where the controller will be responsible for delivering this data.
curl -k -H "Content-Type: application/json" -d '{"password": {"username": "'$_neuvectorUsername_'", "password": "'$_neuvectorPassword_'"}}' "https://$_controllerIP_:$_controllerRESTAPIPort_/v1/auth" > /dev/null 2>&1 > token.json
_TOKEN_=`cat token.json | jq -r '.token.token'`

for i in $(cat api-loop.txt)
do
    curl  -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_"  "https://$_controllerIP_:$_controllerRESTAPIPort_/v1/system/config"  >> debug-status.log
    curl -k -X 'DELETE' -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" "https://$_controllerIP_:$_controllerRESTAPIPort_/v1/auth" >> debug-status.log
done
