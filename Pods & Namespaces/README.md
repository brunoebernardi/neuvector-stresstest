#### Instructions for execution

The "apply-files.sh" script is the first one you should run, as it is the basis for the next scripts. You can customize the number of requests created, namespaces, deployments, and pods.

##### NOTE: Before running the scripts, please test your connection to the Kubernetes & NeuVector cluster and make sure your kubeconfig is correctly mapped.


#### Parallel executions

The "request.sh" script can be run many times to execute as many runs as possible. It is up to the user to define the desired number.


#### Execution information

The execution information will be inserted in the "/tmp" directory in a folder named "NeuVector-Stress-Test" along with its date.

##### NOTE: The main logs are the "top-nodes" and "top-pods", where it will be possible to visualize the idleness of the cluster and the NeuVector resources individually.
