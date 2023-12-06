#Generate 250 requests in each of the pods and namespaces created.
#This will increase the load on the nodes of the kubernetes cluster and also on the enforcers.

DATE=$(date +%Y-%m-%d-%H:%M)

for i in $(cat loop-namespaces.txt)
do
   kubectl exec -it nginx"$i" -n "$i" -- sh -c 'for run in $(seq 1 250); do curl nginx.default.svc.cluster.local; done' >> /tmp/NeuVector-Stress-Test-$DATE/requests.log
done