Pay.setup do |config|
  config.enabled_processors = [:stripe]

  config.default_product_name = "My Awesome App"
  config.default_plan_name = "default-plan"

  config.business_name = "Business Name"
  config.business_address = "1600 Pennsylvania Avenue NW"
  config.application_name = "My App"

  config.send_emails = false
end