require "json"
require "./application_controller.cr"

class InformationController < ApplicationController
  def info
    {type:          config.info["type"],
     state:         config.info["state"],
     serial_number: config.info["serial_number"],
     location:      config.info["location"],
    }.to_json
  end

  def full_metrics
    if config.info["state"] == "enabled"
      config.update_metrics
    end
    config.info.to_json
  end

  def change_state
    config.state = env.params.json["state"].as(String) if env.params.json["state"]?
    puts config.info["state"]
    puts config.state
    {operation_executed: true, state: config.state}.to_json
  end
end
