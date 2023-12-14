#!/bin/bash

DATE=$(date +%Y-%m-%d)

#Setting Working directory
mkdir -p /tmp/NeuVector-Stress-Test-$DATE
cd /tmp/NeuVector-Stress-Test-$DATE
echo -e "The execution information will be saved in /tmp/NeuVector-Stress-Test-$DATE"
sleep 2

#Create a file with a defined number for namespaces and requests
for ((i=1;i<=250;i++)); do echo $i; done > loop-namespaces.txt

#Deployment
kubectl create deployment nginx --image=nginx >> /tmp/NeuVector-Stress-Test-$DATE/services.log
kubectl create service nodeport nginx -n default --tcp=80:80 >> /tmp/NeuVector-Stress-Test-$DATE/services.log

#Create pods, services and requests
for i in $(cat loop-namespaces.txt)
do
   kubectl create ns "$i" >> /tmp/NeuVector-Stress-Test-$DATE/namespaces-created.log
   kubectl create service nodeport nginx"$i" -n "$i" --tcp=80:80 >> /tmp/NeuVector-Stress-Test-$DATE/services-created.log
   #Sleep to allow time for the creation of services in the k8s cluster
   sleep 3
   kubectl run nginx"$i" -n "$i" --image=nginx --restart=Never >> /tmp/NeuVector-Stress-Test-$DATE/pods-created.log
   #Sleep to allow time for the creation of services in the k8s cluster
   sleep 3
   kubectl exec -it nginx"$i" -n "$i" -- sh -c 'for run in $(seq 1 250); do curl nginx.default.svc.cluster.local; done' >> /tmp/NeuVector-Stress-Test-$DATE/requests.log
   kubectl top nodes >> /tmp/NeuVector-Stress-Test-$DATE/top-nodes.log
   kubectl top pods -n cattle-neuvector-system >> /tmp/NeuVector-Stress-Test-$DATE/top-pods-neuvector.log
done
