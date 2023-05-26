# TODO: Write documentation for `MyApp`
require "json"
require "kemal"

module MyApp
    VERSION = "0.1.0"

    get "/" do |env|
     "#{env.response.status} HELLO"
    end

    Kemal.run()
end




