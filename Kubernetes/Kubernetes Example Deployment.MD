# Kubernetes Example Deployment

Tasks:

      1.Create a namespace
      2.Create a Nginx Deployment
      3.Create a Nginx Service   
      4.Expose and access the Nginx Service

## 1.Create a namespace

#### Exercise Folder

To begin the exercise, create a folder names deployment-demo and cd into that folder. Create all the exercise files in this folder.

```sh
mkdir deployment-demo && cd deployment-demo
```
#### Create a Namespace

Let’s create a YAML named namespace.yaml file for creating the namespace.
```sh
apiVersion: v1
kind: Namespace
metadata:
  name: deployment-demo
  labels:
    apps: web-based
  annotations:
    type: demo
```

Use kubectl command to create the namespace.
```sh
kubectl create -f namespace.yaml
```

Equivalent kubectl command
```sh
kubectl create namespace deployment-demo
```

#### Create a Deployment

We will use the public Nginx image for this deployment.

Create a file named deployment.yaml and copy the following YAML to the file

```sh
piVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  labels:
    app: nginx
  namespace: deployment-demo
  annotations:
    monitoring: "true"
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx
        name: nginx
        ports:
        - containerPort: 80
        resources:
          limits:
            memory: "2Gi"
            cpu: "1000m"
          requests: 
            memory: "1Gi"
            cpu: "500m
```
Create the deployment using kubectl
```sh
kubectl create -f deployment.yaml
```

Check the deployment
```sh
kubectl get deployments -n deployment-demo
```
check the deployment in YAML format using the kubectl command.
```sh
kubectl get deployment nginx -n deployment-demo  --output yaml
```
#### Create a Service and Expose The Deployment

Now that we have a running deployment, we will create a Kubernetes service of type NodePort ( 30500) pointing to the nginx deployment. Using NodePort you will be able to access the Nginx service on all the kubernetes node on port 30500.

Create a file named service.yaml and copy the following contents.
```sh
apiVersion: v1
kind: Service
metadata:
  labels:
    app: nginx
  name: nginx
  namespace: deployment-demo
spec:
  ports:
  - nodePort: 30500
    port: 80
    protocol: TCP
    targetPort: 80
  selector:
    app: nginx
  type: NodePort
  ```

  Service is the best example for explaining labels and selectors. In this service, we have a selector with “app” = “nginx” label. Using this, the service will be able to match the pods in our nginx deployment as the deployment and the pods have the same label. So automatically all the requests coming to the nginx service will be sent to the nginx deployment.

  Let’s create the service using kubectl command
  ```sh
  kubectl create -f service.yaml
  ```
  You can view the service created using kubectl command.
  ```sh
  kubectl get services  -n deployment-demo
  ```
  Now, you will be able to access the nginx service on any one of the kubernetes node IP on port 30500
  
  ```sh
  http://35.134.110.153:30500/
  ```
