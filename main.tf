resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.resource_group_name}-azure-kubernetes"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "azure"
  default_node_pool {
    name                  = "default"
    type                  = "VirtualMachineScaleSets"
    enable_auto_scaling   = true
    enable_node_public_ip = false
    max_count             = 3
    min_count             = 1
    os_disk_size_gb       = 256
    vm_size               = "Standard_D2_v2"
  }
  identity {
    type = "SystemAssigned"
  }
  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
  }
}

resource "helm_release" "istio-base" {
  repository = local.istio_charts_url
  chart      = "base"
  name       = "istio-base"
  namespace  = "istio-system"
  version    = var.istio_version
  depends_on = [azurerm_kubernetes_cluster.this]
}

resource "helm_release" "istiod" {
  repository = local.istio_charts_url
  chart      = "istiod"
  name       = "istiod"
  namespace  = "istio-system"
  version    = var.istio_version
  depends_on = [helm_release.istio-base]
}

resource "helm_release" "istio-ingress" {
  repository = local.istio_charts_url
  chart      = "gateway"
  name       = "istio-ingress"
  namespace  = kubernetes_namespace.istio-ingress.id
  version    = var.istio_version
  depends_on = [helm_release.istiod]
}