#!/bin/bash

#This script calls each API-rest script simultaneously and executes the processes in the background via PID, increasing the load on NeuVector and not depending on an open user session.

#Create a file with a defined number for API requests
for ((i=1;i<=250;i++)); do echo $i; done > api-loop.txt
sleep 5

nohup ./api-rest.sh &
nohup ./api-rest.sh &
nohup ./api-rest.sh &
nohup ./api-rest.sh &
nohup ./api-rest.sh &

nohup ./api-rest-2.sh &
nohup ./api-rest-2.sh &
nohup ./api-rest-2.sh &
nohup ./api-rest-2.sh &
nohup ./api-rest-2.sh &

nohup ./api-rest-3.sh &
nohup ./api-rest-3.sh &
nohup ./api-rest-3.sh &
nohup ./api-rest-3.sh &
nohup ./api-rest-3.sh &
