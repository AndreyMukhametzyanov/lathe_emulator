require "kemal"
require "./config.cr"
require "./src/controllers/api/welcome_controller.cr"
require "./src/controllers/api/information_controller.cr"

app_config = Config.new

get "/" do |env|
  WelcomeController.new(app_config, env).index
end

get "/api/info" do |env|
  env.response.content_type = InformationController::CONTENT_TYPE
  InformationController.new(app_config, env).info
end

get "/api/full_metrics" do |env|
  env.response.content_type = InformationController::CONTENT_TYPE
  InformationController.new(app_config, env).info
end

post "/api/change_state" do |env|
  env.response.content_type = InformationController::CONTENT_TYPE
  InformationController.new(app_config, env).info
end

Kemal.run
