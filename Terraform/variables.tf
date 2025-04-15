variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-2"
}

variable "clusterName" {
  description = "EKS Cluster Name"
  type        = string
  default     = "netflix-eks"

}