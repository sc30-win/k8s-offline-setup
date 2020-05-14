# docker version: 19.03.8
# kubernetes version: 1.18.2

# 使用阿里云镜像源
curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

# 创建本地仓库包
yum install --downloadonly --downloaddir=/root/k8sOfflineSetup/packages \
    createrepo

# 实用工具
yum install --downloadonly --downloaddir=/root/k8sOfflineSetup/packages \
    yum-utils \
    nfs-utils \
    wget

# docker 依赖包
yum install --downloadonly --downloaddir=/root/k8sOfflineSetup/packages \
    device-mapper-persistent-data \
    lvm2

# 添加阿里云Docker源
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

# docker
yum install --downloadonly --downloaddir=/root/k8sOfflineSetup/packages \
    docker-ce-19.03.8 \
    docker-ce-cli-19.03.8 \
    containerd.io

# 时间同步
yum install --downloadonly --downloaddir=/root/k8sOfflineSetup/packages \
    chrony

# HAProxy 和 KeepAlived
yum install --downloadonly --downloaddir=/root/k8sOfflineSetup/packages \
    haproxy \
    keepalived

# 配置K8S的yum源
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
       http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

# kubelet
yum install --downloadonly --downloaddir=/root/k8sOfflineSetup/packages \
    kubelet-1.18.2 \
    kubeadm-1.18.2 \
    kubectl-1.18.2