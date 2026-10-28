apply:
	terraform apply

kubeconfig-get:
	terraform output -raw kubeconfig > kubeconfig.yml

kubeconfig-add: kubeconfig-get
	mkdir -p ~/.kube/.backup && cp ~/.kube/config ~/.kube/.backup/config.$$(date +%Y-%m-%d_%H-%M-%S).backup
	KUBECONFIG=kubeconfig.yml:~/.kube/config kubectl config view --raw > /tmp/kubeconfig.merge.yml && cp /tmp/kubeconfig.merge.yml ~/.kube/config

get-versions:
	doctl kubernetes options versions

get-sizes:
	doctl kubernetes options sizes

update-k8s-version:
	.scripts/update-k8s-version.sh

fmt:
	terraform fmt -recursive

fmt-check:
	terraform fmt -recursive -check

setup-git-hooks:
	rm -rf .git/hooks
	(cd .git && ln -s ../.git-hooks hooks)
