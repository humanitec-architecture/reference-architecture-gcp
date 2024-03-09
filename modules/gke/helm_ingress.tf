# Current issue with Autopilot: https://github.com/kubernetes/ingress-nginx/issues/10326
# But after ~4min the Deployment will be successfully created, so not a blocker.

resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.10.0"
  wait             = true
  timeout          = 300

  set {
    name  = "controller.service.loadBalancerIP"
    value = google_compute_address.public_ingress.address
  }

  set {
    name  = "controller.containerSecurityContext.runAsUser"
    value = 101
  }

  set {
    name  = "controller.containerSecurityContext.runAsGroup"
    value = 101
  }

  set {
    name  = "controller.containerSecurityContext.allowPrivilegeEscalation"
    value = false
  }

  set {
    name  = "controller.containerSecurityContext.readOnlyRootFilesystem"
    value = false
  }

  set {
    name  = "controller.containerSecurityContext.runAsNonRoot"
    value = true
  }

  set_list {
    name  = "controller.containerSecurityContext.capabilities.drop"
    value = ["ALL"]
  }

  set_list {
    name  = "controller.containerSecurityContext.capabilities.add"
    value = ["NET_BIND_SERVICE"]
  }
}

