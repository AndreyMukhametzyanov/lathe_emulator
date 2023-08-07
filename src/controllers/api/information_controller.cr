require "json"
require "./application_controller.cr"

class InformationController < ApplicationController
  def info
    {type:          config.type,
     state:         config.state,
     serial_number: config.serial_number,
     location:      config.location,
    }.to_json
  end

  def full_metrics
    config.update_metrics.to_json
  end

  def change_state
    config.state = env.params.json["state"].as(String) if env.params.json["state"]?
    {operation_executed: true, state: config.state}.to_json
  end
end
