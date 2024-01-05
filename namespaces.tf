resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
  }
}

resource "kubernetes_namespace" "istio-ingress" {
  metadata {
    labels = {
      istio-injection = "enabled"
    }

    name = "istio-ingress"
  }
}