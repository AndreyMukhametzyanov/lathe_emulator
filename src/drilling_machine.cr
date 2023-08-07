# TODO: Write documentation for `MyApp`
require "json"
require "kemal"
require "redis"


module MyApp
    VERSION = "0.1.0"   
    redis = Redis.new
    redis.set("status", "active")

    before_all do |env|
        env.response.content_type = "application/json" 
    end

    get "/short_info" do |env|
        info = {
            name: "drillin machine",
            status: redis.get("status"),
            serial_number: "DM001",
            location: "university"
        }.to_json
        info
    end

    get "/full_metrics" do |env|
        if redis.get("status") == "active"
            full_metrics = {
                name: "drillin machine",
                status: "active",
                serial_number: "DM001",
                location: "university",
                current_programm: "#{rand(0..10)}",
                current_instrument: "T#{rand(0..10)}",
                spindle_rotation: "right",
                spindle_speed: "#{rand(0..1000)} rpm",
                x_coordinate: "#{rand(-100..100)}",
                y_coordinate: "#{rand(-100..100)}",
                z_coordinate: "#{rand(-100..100)}",
            }.to_json
        else
            full_metrics = {
                name: "drillin machine",
                status: "inactive",
                serial_number: "DM001",
                location: "university",
                current_programm: "11",
                current_instrument: "T10",
                spindle_rotation: "right",
                spindle_speed: "1000 rpm",
                x_coordinate: "0",
                y_coordinate: "0",
                z_coordinate: "0"
            }.to_json
        end
        p env.response
        full_metrics
    end

    post "/change_state" do |env|
        if redis.get("status")== "active"
           redis.set("status", "inactive")
        else
           redis.set("status", "active")
        end
        Log.info { "Status was changed on #{redis.get("status")}" }
    end

    post "/json_params" do |env|
        puts env.params.inspect
        # name = env.params.json["name"].as(String)
        # likes = env.params.json["likes"].as(Array)
        # "#{name} likes #{likes.join(",")}"
    end
      
    
    Kemal.run()
end




