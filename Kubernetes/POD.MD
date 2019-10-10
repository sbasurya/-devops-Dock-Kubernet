# Pod Overview

## Understanding Pods

A Pod is the basic execution unit of a Kubernetes application–the smallest and simplest unit in the Kubernetes object model that you create or deploy. 

A Pod represents processes running on your Cluster.

A Pod encapsulates an application’s container (or, in some cases, multiple containers), storage resources, a unique network IP, and options that govern how the container(s) should run. 

Pods in a Kubernetes cluster can be used in two main ways:

1. **Pods that run a single container**: The “one-container-per-Pod” model is the most common Kubernetes use case; in this case, you can think of a Pod as a wrapper around a single container, and Kubernetes manages the Pods rather than the containers directly

2. **Pods that run multiple containers that need to work together**: A Pod might encapsulate an application composed of multiple co-located containers that are tightly coupled and need to share resources.

## Networking

- Each Pod is assigned a unique IP address. 

- Every container in a Pod shares the network namespace, including the IP address and network ports. 

- Containers inside a Pod can communicate with one another using localhost

## Storage

A Pod can specify a set of shared storage Volumes. All containers in the Pod can access the shared volumes, allowing those containers to share data.

## Working with Pods

You’ll rarely create individual Pods directly in Kubernetes–even singleton Pods.

This is because Pods are designed as relatively ephemeral, disposable entities. When a Pod gets created (directly by you, or indirectly by a Controller), it is scheduled to run on a Node in your cluster.


