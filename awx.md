# Ansible AWX Installation

Start Minikube with specific settings using the Docker VM driver, 4 CPUs, 8GB of memory, and enable the Ingress add-on

```$ minikube start --vm-driver=docker --cpus=4 --memory=8g --addons=ingress```

Check the status of the Minikube cluster

```$ minikube status```

This command displays the status of the Minikube cluster, including key components like the control plane and kubelet.

Clone the AWX Operator repository from the GitHub

```$ git clone https://github.com/ansible/awx-operator.git```

Change the current directory to the 'awx-operator' directory

```$ cd awx-operator```

Check out a specific version (2.7.1) of the AWX Operator code

```$ git checkout 2.7.1```

Set an environment variable 'NAMESPACE' to the value 'ansible-awx'

```$ export NAMESPACE=ansible-awx```

Build and deploy the AWX Operator using the 'make' command

```$ make deploy```

Copy the contents of 'awx-demo.yml' to a new file named 'ansible-awx.yml'

```cp awx-demo.yml ansible-awx.yml```


Open the 'ansible-awx.yml' file for editing in the 'vi' text editor and set name: ansible-awx
```$ vi ansible-awx.yml```

Set the current Kubernetes context to use the specified 'NAMESPACE' ('ansible-awx')

```$ kubectl config set-context --current --namespace=$NAMESPACE```

This command sets the current Kubernetes context to use the 'NAMESPACE' value, ensuring subsequent commands operate within that namespace.

Apply the configuration defined in the 'ansible-awx.yml' file to create AWX resources in the Kubernetes cluster

```$ kubectl apply -f ansible-awx.yml```

Retrieve and display the admin password from the 'ansible-awx-admin-password' secret in decoded form

```$ kubectl get secret ansible-awx-admin-password -o jsonpath="{.data.password}" | base64 --decode; echo```

Forward port 10445 on the local machine to port 80 of the 'ansible-awx-service' in the Kubernetes cluster

```$ kubectl port-forward service/ansible-awx-service --address 0.0.0.0 10445:80```

This command sets up port forwarding to access the AWX service locally.
The displayed message indicates that local port 10445 is forwarding traffic to port 80 of the AWX service.