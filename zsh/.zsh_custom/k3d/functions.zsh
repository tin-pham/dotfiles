create_k3d_cluster() {
  local cluster_name=$1
  local host_ip=$2

  if [[ -z "$cluster_name" || -z "$host_ip" ]]; then
    echo "Usage: create_k3d_cluster <cluster_name> <host_ip>"
    return 1
  fi

  k3d cluster create "$cluster_name" -a 1 --port 8080:80@loadbalancer --port 443:443@loadbalancer --api-port "$host_ip":6443 --servers 1 --k3s-arg "--disable=traefik@server:0"
}

delete_k3d_cluster() {
  local cluster_name=$1
  if [[ -z "$cluster_name" ]]; then
    echo "Usage: delete_k3d_cluster <cluster_name>"
    return 1
  fi
  k3d cluster delete "$cluster_name"
}
