class Config
  property state : String = "enabled"
  property info  : Hash(String, String)

  def initialize
    @state = state
    @info = {
      "type" => "lathe machine",
      "state" => @state,
      "serial_number" =>"DM001",
      "location" =>"university",
      "current_programm" => "#{rand(0..10)}",
      "current_instrument" => "T#{rand(0..10)}",
      "spindle_rotation" => "right",
      "spindle_speed" => "#{rand(0..1000)} rpm",
      "x_coordinate" => "#{rand(-100..100)}",
      "y_coordinate" => "#{rand(-100..100)}",
      "z_coordinate" => "#{rand(-100..100)}"
     }   
  end
end
