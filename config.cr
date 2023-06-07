class Config
  property state : String
  property info : Hash(String, String)

  def initialize
    @state = "enabled"
    @info = {
      "type"               => "lathe machine",
      "state"              => "#{@state}",
      "serial_number"      => "DM001",
      "location"           => "university",
      "current_programm"   => "#{rand(0..10)}",
      "current_instrument" => "T#{rand(0..10)}",
      "spindle_rotation"   => "right",
      "spindle_speed"      => "#{rand(0..1000)} rpm",
      "x_coordinate"       => "#{rand(-100..100)}",
      "y_coordinate"       => "#{rand(-100..100)}",
      "z_coordinate"       => "#{rand(-100..100)}",
    }
  end

  def update_metrics
    @info["current_programm"] = "T#{rand(0..10)}"
    @info["spindle_speed"] = "#{rand(0..1000)} rpm"
    @info["x_coordinate"] = "#{rand(-100..100)}"
    @info["y_coordinate"] = "#{rand(-100..100)}"
    @info["z_coordinate"] = "#{rand(-100..100)}"
  end
end
