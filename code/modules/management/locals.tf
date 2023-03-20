locals {
  root_id = var.root_id
  log_analytics_solutions = {
    Security : {
      solution_name = "Security"
      plan = {
        publisher = "Microsoft"
        product   = "OMSGallery/Security"
      }
    },
    SecurityInsights : {
      solution_name = "SecurityInsights"
      plan = {
        publisher = "Microsoft"
        product   = "OMSGallery/SecurityInsights"
      }
    }
  }

  log_analytics_data_source_types = [
    "CustomLogs",
    "AzureWatson",
    "Query",
    "Ingestion",
    "Alerts"
  ]
  storage_container_names = []
}
