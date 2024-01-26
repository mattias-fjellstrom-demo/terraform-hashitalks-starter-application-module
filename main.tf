resource "kubernetes_manifest" "argocd_application" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "Application"
    "metadata" = {
      "name"      = "hello-world"
      "namespace" = "argocd"
    }
    "spec" = {
      "project" = "default"
      "source" = {
        "repoURL"        = "https://github.com/mattias-fjellstrom-demo/hello-hashitalks-app"
        "targetRevision" = var.revision
        "path"           = "manifests"
      }
      "destination" = {
        "server"    = "https://kubernetes.default.svc"
        "namespace" = "default"
      }
      "syncPolicy" : {
        "automated" : {
          "selfHeal" : "true"
          "prune" : "true"
        }
      }
    }
  }
}
