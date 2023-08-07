require "./spec_helper"

describe "app" do
  describe "#info" do
    it "renders the welcome page" do
      get "/"
      response.status_code.should eq 200
    end

    it "renders info page" do
      yml = YAML.parse(File.read("./start.yml"))
      my = {"type"          => yml["type"].to_s,
            "state"         => "enabled",
            "serial_number" => yml["serial_number"].to_s,
            "location"      => "university"}

      get "/api/info"
      response.status_code.should eq 200
      JSON.parse(response.body).should eq my
    end

    it "renders info page when start.yml not found" do
      msg = "Error opening file with mode 'r': './error.yml': No such file or directory"
      my = {"type"          => "drilling",
            "state"         => "enabled",
            "serial_number" => "123456",
            "location"      => "university"}
            
      expect_raises(File::NotFoundError, msg) do
        yml = YAML.parse(File.read("./error.yml"))
        get "/api/info"
        response.status_code.should eq 200
        JSON.parse(response.body).should eq my
      end
    end

    it "renders info page when start.yml not found" do
      msg = "Error opening file with mode 'r': './error.yml': No such file or directory"
      expect_raises(File::NotFoundError, msg) do
        yml = YAML.parse(File.read("./error.yml"))
      end
    end
  end
  
  describe "#full_metrics" do
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
  end

  describe "#change_state" do
    it "change state to disabled" do
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

      new_data = {"operation_executed": true, "state": "enabled"}.to_json

      post "/api/change_state", headers: HTTP::Headers{"Content-Type" => "application/json"}, body: {"state" => "enabled"}.to_json
      response.status_code.should eq 200
      response.body.should eq new_data

      get "/api/full_metrics"
      new_metrics = JSON.parse(response.body)

      response.status_code.should eq 200
      new_metrics["state"].should eq "enabled"

      get "/api/full_metrics"
      new_metrics2 = JSON.parse(response.body)

      response.status_code.should eq 200
      new_metrics.as_h.values.should_not eq new_metrics2.as_h.values
    end
  end
end
