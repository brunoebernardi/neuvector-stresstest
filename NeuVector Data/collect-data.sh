#/bin/bash

#Get Controller Logs
for i in `kubectl get pods -n cattle-neuvector-system | grep controller | awk '{print $1}'`;do kubectl logs $i -n cattle-neuvector-system > $i.log; done

#Get Security Rules
kubectl get nvsecurityrules.neuvector.com -A >> nvsecurityrules.txt

#Get CRD Processed
for i in `kubectl get pods -n cattle-neuvector-system | grep controller | awk '{print $1}'`; do kubectl exec $i -n cattle-neuvector-system -- consul kv get -recurse object/config/crd/ > crd_processed-$i.log; done