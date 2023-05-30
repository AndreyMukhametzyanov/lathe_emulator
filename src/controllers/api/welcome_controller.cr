require "json"
require "./application_controller.cr"

class WelcomeController < ApplicationController
  def index
    "https://www.youtube.com/watch?v=R4VjmOAdAI8"
  end

  def current_state
    {state: config.state}.to_json
  end

  def change_state
    config.state = env.params.json["state"].as(String) if env.params.json["state"]?
    {operation_executed: true, state: config.state}.to_json
  end
end
