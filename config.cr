require "yaml"

class Config
  YML = YAML.parse(File.read("./start.yml"))

  property state : String = "enabled"
  property type : String = YML["type"].to_s
  property serial_number : String = YML["serial_number"].to_s
  property location : String = "university"
  property info : Hash(String, String)

  def initialize
    @state = state
    @type = type
    @serial_number = serial_number
    @location = location
    @info = init_hash
  end

  def update_metrics(state)
    if state == "enabled"
      @info["current_programm"] = "T#{rand(0..10)}"
      @info["spindle_speed"] = "#{rand(0..1000)} rpm"
      @info["x_coordinate"] = "#{rand(-100..100)}"
      @info["y_coordinate"] = "#{rand(-100..100)}"
      @info["z_coordinate"] = "#{rand(-100..100)}"
    else
      @info["state"] = "disabled"
    end
    @info
  end

  private def init_hash
    yml = YAML.parse(File.read("./start.yml"))
    puts yml["serial_number"].to_s
    {
      "type"               => @type,
      "state"              => @state,
      "serial_number"      => @serial_number,
      "location"           => @location,
      "current_programm"   => "#{rand(0..10)}",
      "current_instrument" => "T#{rand(0..10)}",
      "spindle_rotation"   => "right",
      "spindle_speed"      => "#{rand(0..1000)} rpm",
      "x_coordinate"       => "#{rand(-100..100)}",
      "y_coordinate"       => "#{rand(-100..100)}",
      "z_coordinate"       => "#{rand(-100..100)}",
    }
  end
end
