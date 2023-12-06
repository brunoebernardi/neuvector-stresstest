#!/bin/bash

DATE=$(date +%Y-%m-%d-%H:%M)

#Generate a stress task in controllers

#NeuVector ENV
_controllerIP_=""
_controllerRESTAPIPort_="" #NodePort
_neuvectorUsername_="admin"
_neuvectorPassword_=""


# The snippet below will create several groups and network rules in NeuVector following a standard MySQL rule template. No matter the standard, the main focus is to overload the controllers as much as possible.
for i in $(cat api-loop.txt)
do
    curl -k -H "Content-Type: application/json" -d '{"password": {"username": "'$_neuvectorUsername_'", "password": "'$_neuvectorPassword_'"}}' "https://$_controllerIP_:$_controllerRESTAPIPort_/v1/auth" > /dev/null 2>&1 > token.json
    _TOKEN_=`cat token.json | jq -r '.token.token'`
    curl -k -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" -d '{"config": {"name": "'group-$i'", "criteria": [{"value": "data", "key": "nv.service.type", "op": "="}]}}' "https://$_controllerIP_:$_controllerRESTAPIPort_/v1/group" 
    curl -k -X "PATCH" -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" -d '{"insert": {"rules": [{"comment": "Custom WP Rule", "from": "'group-$i'", "applications": ["MYSQL"], "ports": "any", "to": "mydb", "action": "allow", "id": 0}], "after": 0}}' "https://$_controllerIP_:$_controllerRESTAPIPort_/v1/policy/rule"
    curl -k -X 'DELETE' -H "Content-Type: application/json" -H "X-Auth-Token: $_TOKEN_" "https://$_controllerIP_:$_controllerRESTAPIPort_/v1/auth" 
done

