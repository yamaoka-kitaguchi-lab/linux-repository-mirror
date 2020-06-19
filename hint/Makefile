create-pv:
	microk8s kubectl apply -f pv-hostpath.yaml

deploy-metrics-server:
	microk8s kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml
	microk8s kubectl top node
	microk8s kubectl top pod

import-image:
	docker save docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/archlinux-mirror:latest > archlinux-mirror.tar
	docker save docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/manjaro-mirror:latest > manjaro-mirror.tar
	docker save docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/ubuntu-mirror:latest > ubuntu-mirror.tar
	docker save docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/debian-mirror:latest > debian-mirror.tar
	docker save docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/raspbian-mirror:latest > raspbian-mirror.tar
	docker save docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/gentoo-mirror:latest > gentoo-mirror.tar
	docker save docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/mirror-index-nginx:latest > mirror-index-nginx.tar
	microk8s ctr image import archlinux-mirror.tar
	microk8s ctr image import manjaro-mirror.tar
	microk8s ctr image import ubuntu-mirror.tar
	microk8s ctr image import debian-mirror.tar
	microk8s ctr image import raspbian-mirror.tar
	microk8s ctr image import gentoo-mirror.tar
	microk8s ctr image import mirror-index-nginx.tar
	rm archlinux-mirror.tar
	rm manjaro-mirror.tar
	rm ubuntu-mirror.tar
	rm debian-mirror.tar
	rm raspbian-mirror.tar
	rm gentoo-mirror.tar
	rm mirror-index-nginx.tar
	microk8s ctr images ls

retag-image:
	docker tag docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/archlinux-mirror:latest localhost:32000/archlinux-mirror:latest
	docker tag docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/manjaro-mirror:latest localhost:32000/manjaro-mirror:latest
	docker tag docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/ubuntu-mirror:latest localhost:32000/ubuntu-mirror:latest
	docker tag docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/debian-mirror:latest localhost:32000/debian-mirror:latest
	docker tag docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/raspbian-mirror:latest localhost:32000/raspbian-mirror:latest
	docker tag docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/gentoo-mirror:latest localhost:32000/gentoo-mirror:latest
	docker tag docker.pkg.github.com/yamaoka-kitaguchi-lab/linux-repository-mirror/mirror-index-nginx:latest localhost:32000/mirror-index-nginx:latest

push-image:
	docker push localhost:32000/archlinux-mirror:latest
	docker push localhost:32000/manjaro-mirror:latest
	docker push localhost:32000/ubuntu-mirror:latest
	docker push localhost:32000/debian-mirror:latest
	docker push localhost:32000/raspbian-mirror:latest
	docker push localhost:32000/gentoo-mirror:latest
	docker push localhost:32000/mirror-index-nginx:latest
