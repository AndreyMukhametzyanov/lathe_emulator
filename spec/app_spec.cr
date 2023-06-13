require "./spec_helper"

describe "app" do
  it "renders the welcome page" do
    get "/"
    response.status_code.should eq 200
  end

  it "renders info page" do
    my = {"type"          => "lathe machine",
          "state"         => "enabled",
          "serial_number" => "DM001",
          "location"      => "university"}

    get "/api/info"
    response.status_code.should eq 200
    JSON.parse(response.body).should eq my
  end

  it "renders full metrics page with updatable data" do
    keys = ["type", "state", "serial_number", "location",
            "current_programm", "current_instrument", "spindle_rotation",
            "spindle_speed", "x_coordinate", "y_coordinate", "z_coordinate"]

    get "/api/full_metrics"
    data_hash = JSON.parse(response.body)
    response.status_code.should eq 200
    data_hash.as_h.keys.should eq keys

    get "/api/full_metrics"
    data_hash2 = JSON.parse(response.body)
    response.status_code.should eq 200
    data_hash.as_h.values.should_not eq data_hash2.as_h.values
  end

  it "change state" do
    data = {"operation_executed": true, "state": "disabled"}.to_json

    post "/api/change_state", headers: HTTP::Headers{"Content-Type" => "application/json"}, body: {"state" => "disabled"}.to_json
    response.status_code.should eq 200
    response.body.should eq data

    get "/api/full_metrics"
    data_hash = JSON.parse(response.body)

    response.status_code.should eq 200
    data_hash["state"].should eq "disabled"

    get "/api/full_metrics"
    data_hash2 = JSON.parse(response.body)

    response.status_code.should eq 200
    data_hash.as_h.values.should eq data_hash2.as_h.values
  end
end
