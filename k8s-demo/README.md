## Kubernetes Notes - Essential Commands and Examples

Kubernetes, or K8s for short, is a container orchestration platform that automates the deployment, scaling, and management of containerized applications. Here are some essential kubectl commands you'll use to interact with Kubernetes clusters:

1. Getting Started:

``kubectl version``: Shows the version of the kubectl client you're using.

``kubectl config view``: Displays your current Kubernetes cluster configuration.

``kubectl get clusters``: Lists all Kubernetes clusters configured on your system. (If you only have one, it might not show up here)

2. Managing Resources:
```
kubectl get <resource>: Retrieves information about resources (e.g., kubectl get pods, kubectl get deployments).

kubectl describe <resource>: Provides detailed information about a specific resource (e.g., kubectl describe pod my-pod).

kubectl create -f <filename.yaml>: Creates Kubernetes resources from a YAML file containing the resource definitions.

kubectl delete -f <filename.yaml>: Deletes Kubernetes resources specified in a YAML file.

kubectl apply -f <filename.yaml>: Creates or updates resources based on the YAML definitions. (This combines create and update functionality.)
```
Example:

Bash
- Get a list of pods in the default namespace:
``kubectl get pods``

- Describe a specific pod named "my-pod":
``kubectl describe pod my-pod``

- Create a deployment from a YAML file:
``kubectl create -f deployment.yaml``

- Delete a deployment:
```kubectl delete deployment my-deployment```

# Apply a configuration that might update or create resources:
``kubectl apply -f config.yaml``
Use code with caution.
3. Logs and Debugging:

``kubectl logs <pod-name>``: Retrieves logs from a running pod.
``kubectl exec -it <pod-name> -- bash``: Opens a bash shell within a running pod for interactive troubleshooting.

4. Pod Management:

``kubectl run <pod-name> --image=<image-name>``: Creates a simple pod with a container running the specified image.

``kubectl delete pod <pod-name>``: Deletes a pod.

5. Namespaces:

``kubectl get namespaces``: Lists all namespaces in the cluster.

``kubectl get pods -n <namespace-name>``: Retrieves pods within a specific namespace (if different from the default).

6. Services:

``kubectl get services``: Lists all services in the cluster.

``kubectl expose deployment <deployment-name> --type=LoadBalancer``: Exposes a deployment as a LoadBalancer service for external access.

7. Scaling:

``kubectl scale deployment <deployment-name> --replicas=<number>``: Scales the number of replicas for a deployment.
These are just some of the most common ``kubectl`` commands. For a comprehensive list of commands and detailed explanations, refer to the official Kubernetes documentation:

https://kubernetes.io/docs/home/

Additional Tips:

Use flags with kubectl commands for additional customization (e.g., -o wide for wider output, ``-l label=key=value`` for filtering resources by labels).

Explore online resources and tutorials for specific Kubernetes use cases and best practices.
Consider using tools like kubectl cheat sheet or online cheat sheets for quick reference.
By understanding these basic commands and exploring the documentation, you'll be well on your way to effectively managing your containerized applications using Kubernetes.

## Kubernetes Architecture

Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications. It groups containerized applications into logical units for easy management and enables them to run across a cluster of machines.

# Key Components:

- Control Plane:

The brain of Kubernetes, responsible for managing the worker nodes and the overall state of the cluster.
- Components:

``API Server``: The central point of communication for Kubernetes, accepting commands from kubectl (command-line tool) or other clients.

``Scheduler``: Assigns pods (groups of containers) to worker nodes based on resource availability and pod requirements.

``Controller Manager``: Manages the lifecycle of pods, replicasets, deployments, and other resources by ensuring their desired state is maintained.

``etcd``: A highly available key-value store that stores the shared state of the cluster (cluster configuration, pod information, etc.).
Worker Nodes:

The machines where containerized applications run.

``Components``:
kubelet: The agent running on each worker node, responsible for managing pods, fetching container images from the container registry, and running containers.

``Kube-proxy``: Implements network proxy services to route traffic to pods within the cluster.

``Container Runtime``: Manages the lifecycle of containers (e.g., Docker, containerd).
Pods:

# The basic unit of deployment in Kubernetes
. A ``pod`` represents a group of one or more containers that are meant to be deployed together and share storage (volume).
Pods are ephemeral (can be recreated), while deployments manage the creation and scaling of pods.

``Deployments``:
Kubernetes objects that provide declarative descriptions of pods. A deployment defines the desired state of pods (number of replicas, container images, resource requests/limits).
The controller manager manages deployments, ensuring the specified number of pods are running and restarting them if they fail.
Services:

Abstractions that provide a way to access a set of pods as a single unit. Services expose endpoints for pods and handle load balancing across them.

``Namespaces``:
Logical partitions within a Kubernetes cluster that allow for separation of resources by project, team, or environment.
How Kubernetes Functions:

``Deployment Creation``:
You create a deployment YAML file defining the desired state of pods (images, replicas, etc.).
Deployment Submission:
The deployment YAML is applied using kubectl apply.
``API Server Communication``:
The kubectl command interacts with the API server, submitting the deployment configuration.

``Scheduler Assignment``:
The scheduler analyzes the deployment and pod needs, then assigns pods to worker nodes based on available resources.

``Worker Node Execution``:
The kubelet on each worker node receives instructions from the API server.
The kubelet fetches container images from the container registry.
The kubelet creates and runs pods according to the deployment specifications.

``Pod Management``:
The controller manager in the control plane continuously monitors pods.
If a pod fails, the controller manager restarts it based on the deployment definition.
Conceptual Diagram (Text-Based):
```
+-------------------+          +-------------------+          +-------------------+
| kubectl (client) |          | API Server        |          | etcd               |
+-------------------+          +-------------------+          +-------------------+
                    |
                    | (REST API)
                    |
+-------------------+          +-------------------+          +-------------------+
| Scheduler        |          | Controller        |          |                     |
+-------------------+          | Manager           |          +-------------------+
                    |
                    | (manages deployments,     |
                    | replicasets, pods, etc.) |
                    |
+-------------------+          +-------------------+          +-------------------+
| Worker Node 1     |          | Worker Node 2     |          | Worker Node N     |
+-------------------+          +-------------------+          +-------------------+
    | kubelet         |          | kubelet         |          | kubelet         |
    | kube-proxy      |          | kube-proxy      |          | kube-proxy      |
    | Container       |          | Container       |          | Container       |
    | Runtime         |          | Runtime         |          | Runtime         |
+-------------------+          +-------------------+          +-------------------+
    | Pod 1 (multiple |          | Pod 2
```

[Sources](https://tanzu.vmware.com/open-source)
