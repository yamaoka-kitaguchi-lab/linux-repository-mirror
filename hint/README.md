## Install and setup microk8s

```
% snap install --classic microk8s
% microk8s enable dashboard dns helm3 registry storage 
```

## microk8s: Working with locally built images without a registry

See: https://microk8s.io/docs/registry-images

```
% docker save docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/archlinux-mirror:latest > archlinux-mirror.tar
% microk8s ctr image import archlinux-mirror.tar
% rm archlinux-mirror.tar
% rm archlinux-mirror.tar
% microk8s ctr images ls
```

## Create PV (Persistent Volume) on local node

For assign PV-PVC bindings manually, do not specify `StorageClass` in PVCs:

```
annotations:
  volume.beta.kubernetes.io/storage-class: ""
```

Create and delete PVs:

```
% microk8s kubectl apply -f pv-hostpath.yaml
% microk8s kubectl delete -f pv-hostpath.yaml
```

## Deploy metrics-server for HPA

See: https://github.com/kubernetes-sigs/metrics-server

```
% microk8s kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml
% microk8s kubectl top node
% microk8s kubectl top pod
```
