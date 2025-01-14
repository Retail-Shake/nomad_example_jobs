job "example" {
  datacenters = ["dc1"]

  group "cache" {
    task "redis" {
      driver = "docker"

      config {
        image = "redis:7"

        port_map {
          db = 6379
        }
	labels {
          com.datadoghq.ad.logs = <<EOF
            [{
              "source": "atlas",
              "service": "atlas",
              "log_processing_rules": [{
                "type": "exclude_at_match",
                "name": "archivist_sensitive_urls",
                "pattern": "Archivist upload completion callback received"
              }]
            }]
EOF
	}
      }

      resources {
        cpu    = 500
        memory = 256

        network {
          mbits = 10
          port "db" {}
        }
      }
    }
  }
}
