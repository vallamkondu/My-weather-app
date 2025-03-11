variable "docker_version" {
    type = string
    default = "latest"
}
variable "buildah_version" {
    type = string
    default = "latest"
}
variable "kubectl_version" {
    type = string
    default = "latest"
}
variable "helm_version" {
    type = string
    default = "latest"
}
variable "region" {
    type = string
    default = "eu-north-1"
}
variable "ami_name" {
    type = string
    default = "my-ami"
}
variable "instance_type" {
    type = string
    default = "t3.micro"
}