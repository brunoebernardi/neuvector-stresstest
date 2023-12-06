#!/bin/bash

DATE=$(date +%Y-%m-%d-%H:%M)

#Create namespaces for CRDs
for ns in $(cat namespaces.txt)
do
   kubectl create ns "$ns" >> /tmp/NeuVector-Stress-Test-$DATE/crd-namespaces.log
done

#Apply CRDs
for crd in $(cat crd.txt)
do
   kubectl apply -f "$crd" >> /tmp/NeuVector-Stress-Test-$DATE/crd-apply.log
   sleep 3
done