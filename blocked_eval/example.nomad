job "example" {
  datacenters = ["dc1"]

  constraint {
    attribute = "${meta.waituntil}"
    operator  = "="
    value     = "charlie"
  }

  group "cache" {
    network {
      port "db" {
        to = 6379
      }
    }

    task "redis" {
      driver = "docker"

      config {
        image          = "redis:7"
        ports          = ["db"]
        auth_soft_fail = true
      }

      resources {
        cpu    = 500
        memory = 256
      }
    }
  }
}
