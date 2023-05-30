require "kemal"
require "./config.cr"
require "./src/controllers/api/welcome_controller.cr"

app_config = Config.new

get "/" do |env|
  WelcomeController.new(app_config, env).index
end

get "/api/current_state" do |env|
  env.response.content_type = WelcomeController::CONTENT_TYPE
  WelcomeController.new(app_config, env).current_state
end

post "/api/change_state" do |env|
  env.response.content_type = WelcomeController::CONTENT_TYPE
  WelcomeController.new(app_config, env).change_state
end

Kemal.run
