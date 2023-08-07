require "json"
require "./application_controller.cr"

class WelcomeController < ApplicationController
  def index
    @machine_type = config.type.as(String)
    render "src/views/welcome/index.ecr", "src/views/layouts/layout.ecr"
  end
end
