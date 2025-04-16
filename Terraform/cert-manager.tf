module "cert-manager" {
    source = "https://github.com/Cjay13/terraform-kubernetes-cert-manager.git?ref=main"
    chart_version            = "v1.17.0"
    create_clusterIssuer     = true
    clusterIssuer_name       = "letsencrypt-prod"
    acme_server_url          = "https://acme-v02.api.letsencrypt.org/directory"
    letsencrypt_email        = "herath.charithjay@gmail.com"
    private_key_secret_name  = "letsencrypt-prod"
    ingress_class            = "nginx"
}