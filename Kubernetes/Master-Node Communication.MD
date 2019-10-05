# Master-Node Communication

## Cluster to Master

All communication paths from the cluster to the master terminate at the apiserver (none of the other master components are designed to expose remote services).

In a typical deployment, the apiserver is configured to listen for remote connections on a secure HTTPS port (443) with one or more forms of client authentication enabled. One or more forms of authorization should be enabled, especially if anonymous requests or service account tokens are allowed.

Nodes should be provisioned with the public root certificate for the cluster such that they can connect securely to the apiserver along with valid client credentials.

Pods that wish to connect to the apiserver can do so securely by leveraging a service account so that Kubernetes will automatically inject the public root certificate and a valid bearer token into the pod when it is instantiated

The master components also communicate with the cluster apiserver over the secure port.

## Master to Cluster

There are two primary communication paths from the master (apiserver) to the cluster. 
1. The first is from the apiserver to the kubelet process which runs on each node in the cluster
2. The second is from the apiserver to any node, pod, or service through the apiserver’s proxy functionality.

### apiserver to kubelet
The connections from the apiserver to the kubelet are used for:
- Fetching logs for pods.
- Attaching (through kubectl) to running pods.
- Providing the kubelet’s port-forwarding functionality.

These connections terminate at the kubelet’s HTTPS endpoint.

By default, the apiserver does not verify the kubelet’s serving certificate, which makes the connection subject to man-in-the-middle attacks, and unsafe to run over untrusted and/or public networks

To verify this connection, use the --kubelet-certificate-authority flag to provide the apiserver with a root certificate bundle to use to verify the kubelet’s serving certificate.

If that is not possible, use SSH tunneling between the apiserver and kubelet if required to avoid connecting over an untrusted or public network.

### apiserver to nodes, pods, and services

The connections from the apiserver to a node, pod, or service default to plain HTTP connections and are therefore neither authenticated nor encrypted

