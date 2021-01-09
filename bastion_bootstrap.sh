#!/bin/bash -e

function install_kubernetes_client_tools() {
    mkdir -p /usr/local/bin/
    curl --retry 5 -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.8/2020-09-18/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/
    sudo cat > /etc/profile.d/kubectl.sh <<EOF
#!/bin/bash
if [[ ":$PATH:" != *":/usr/local/bin:"* ]]; then     PATH="$PATH:/usr/local/bin";   fi
source <(kubectl completion bash)
EOF
    chmod +x /etc/profile.d/kubectl.sh
    curl --retry 5 -o helm.tar.gz https://get.helm.sh/helm-v3.3.4-linux-amd64.tar.gz
    tar -xvf helm.tar.gz
    chmod +x ./linux-amd64/helm
    sudo mv ./linux-amd64/helm /usr/local/bin/helm
    rm -rf ./linux-amd64/
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
    sudo sudo mv /tmp/eksctl /usr/local/bin
    rm -rf /tmp/*
}

install_kubernetes_client_tools
