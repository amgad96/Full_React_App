terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}
resource "aws_vpc" "KubeVPC" {
  cidr_block = "172.10.0.0/16"
   tags = {
    Name = "KubeVPC"
   }
}
resource "aws_internet_gateway" "kube_cluster_gw" {
  vpc_id = aws_vpc.KubeVPC.id
  tags = {
    Name = "kube"
  }
}
module pubsubnet {
  source = "./modules/pubsubnet"
  kube_vpc  = aws_vpc.KubeVPC
  kube_igw = aws_internet_gateway.kube_cluster_gw
  sub_cidrblock = "172.10.0.0/24"
  sub_avail_zone = "us-east-1a"
}
module pubsubnet2 {
  source = "./modules/pubsubnet"
  kube_vpc  = aws_vpc.KubeVPC
  kube_igw = aws_internet_gateway.kube_cluster_gw
  sub_cidrblock = "172.10.1.0/24"
  sub_avail_zone = "us-east-1b"
}
module SecurityGroups {
  source = "./modules/SGmodule"
  kube_vpc = aws_vpc.KubeVPC
  subnet_cidrblock = module.pubsubnet.pubsubnet_cidrblock
}
module masternode {
  source = "./modules/pubec2"
  kube_pubsubnet_id = module.pubsubnet.pubsubnet_id
  ece_role = "master"
  kube_vpc  = aws_vpc.KubeVPC
  subnet_cidrblock = module.pubsubnet.pubsubnet_cidrblock
  node_count = 1
  # Attach MasterNodeSG to this instance
  Kube_SG_id = module.SecurityGroups.Master_SG.id
}
module workernodes {
  source = "./modules/pubec2"
  kube_pubsubnet_id = module.pubsubnet.pubsubnet_id
  ece_role = "worker"
  kube_vpc  = aws_vpc.KubeVPC
  subnet_cidrblock = module.pubsubnet.pubsubnet_cidrblock
  node_count = 2
  Kube_SG_id = module.SecurityGroups.Worker_SG.id
}
module Backend_LB {
 source = "./modules/LB_TG"
 LB_name = "Backend-LB"
 workernode_instances = module.workernodes.instances
 LB_SG_IDS = module.SecurityGroups.LB_SGs_ids
 SubnetA = module.pubsubnet.pubsubnet_id
 SubnetB = module.pubsubnet2.pubsubnet_id
 kube_vpc = aws_vpc.KubeVPC
 listenport = 80
 TG_Name = "Backend-TG"
 targ_port = 30007
}
module Frontend_LB {
 source = "./modules/LB_TG"
 LB_name = "Frontend-LB"
 workernode_instances = module.workernodes.instances
 LB_SG_IDS = module.SecurityGroups.LB_SGs_ids
 SubnetA = module.pubsubnet.pubsubnet_id
 SubnetB = module.pubsubnet2.pubsubnet_id
 kube_vpc = aws_vpc.KubeVPC
 TG_Name = "Frontend-TG"
 listenport = 80
 targ_port = 30008
}