apply:
	terraform apply

kubeconfig-get:
	terraform output -raw kubeconfig > kubeconfig.yml

kubeconfig-add: kubeconfig-get
	cp ~/.kube/config ~/.kube/config.$$(date +%Y-%m-%d_%H-%M-%S).backup
	KUBECONFIG=kubeconfig.yml:~/.kube/config kubectl config view --raw > /tmp/kubeconfig.merge.yml && cp /tmp/kubeconfig.merge.yml ~/.kube/config

get-versions:
	doctl kubernetes options versions

get-sizes:
	doctl kubernetes options sizes

commit-k8s-version-update:
	git add config.tf && git commit -m "feat(k8s): Update Kubernetes version"

install-essentials:
	make install-ingress
	make install-cert-manager
	make install-clusterissuer-letsencrypt

install-ingress:
	helm upgrade --install \
		ingress-nginx ingress-nginx \
		--repo https://kubernetes.github.io/ingress-nginx \
		--create-namespace \
		--namespace ingress-nginx \
		--wait \
		--values ./ingress-nginx.values.yml

install-cert-manager:
	helm upgrade --install \
		cert-manager cert-manager \
		--repo https://charts.jetstack.io \
		--create-namespace \
		--namespace cert-manager \
		--wait \
		--values ./cert-manager.values.yml

install-clusterissuer-letsencrypt:
	kubectl apply -f clusterissuer-letsencrypt.yml

install-metrics-server:
	kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

fmt:
	terraform fmt -recursive

fmt-check:
	terraform fmt -recursive -check

setup-git-hooks:
	rm -rf .git/hooks
	(cd .git && ln -s ../.git-hooks hooks)
