require "kemal"
require "./config.cr"
require "./config_loader.cr"
require "./src/controllers/api/welcome_controller.cr"
require "./src/controllers/api/information_controller.cr"

app_config = ConfigLoader.loader

get "/" do |env|
  WelcomeController.new(app_config, env).index
end

get "/api/info" do |env|
  env.response.content_type = InformationController::CONTENT_TYPE
  InformationController.new(app_config, env).info
end

get "/api/full_metrics" do |env|
  env.response.content_type = InformationController::CONTENT_TYPE
  InformationController.new(app_config, env).full_metrics
end

post "/api/change_state" do |env|
  env.response.content_type = InformationController::CONTENT_TYPE
  InformationController.new(app_config, env).change_state
end

Kemal.run
