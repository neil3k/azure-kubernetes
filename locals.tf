locals {
  istio_charts_url = "https://istio-release.storage.googleapis.com/charts"
}

#Create a local kube config file for use by the helm provider
resource "local_file" "kube_config" {
  content  = azurerm_kubernetes_cluster.this.kube_config_raw
  filename = ".kube/config"

  depends_on = [azurerm_kubernetes_cluster.this]
}

#Create Istio template file
resource "local_file" "istio-config" {
  content = templatefile("${path.module}/istio-aks.tmpl", {
    enableGrafana = true
    enableKiali   = true
    enableTracing = true
  })
  filename = ".istio/istio-aks.yaml"
}