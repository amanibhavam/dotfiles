package control

provider: kubernetes: [{
	config_context: "k3d-control"
	config_path:    "~/.kube/config"
}]

locals: [{
	envs: control: {
		domain: "tiger-mamba.ts.net"
		host:   "k3d-control"
	}
}]

module: devpod: [{
	envs:   "${local.envs}"
	source: "../m/devpod"
}]
