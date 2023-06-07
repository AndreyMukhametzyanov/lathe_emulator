class ApplicationController
  CONTENT_TYPE = "application/json"

  property :config
  property :env

  def initialize(config : Config, env : HTTP::Server::Context)
    @config = config
    @env = env
  end
end
