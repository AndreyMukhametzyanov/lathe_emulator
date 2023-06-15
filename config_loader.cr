require "yaml"
require "log"

class ConfigLoader
  def self.loader
    yml = YAML.parse(File.read("./start.yml"))
    if yml.to_s.empty?
      Config.new
    else
      Kemal.config.port = yml["port"].to_s.to_i
      Kemal.config.host_binding = yml["ip"].to_s
      Config.new(yml["type"].to_s, yml["serial_number"].to_s)
    end
  rescue File::NotFoundError
    Log.info { "File not found start.yml file. Default config was used" }
    Config.new
  rescue e
    Log.info { "Error reading start.yml file: #{e.class}. Default config was used" }
    Config.new
  end
end
