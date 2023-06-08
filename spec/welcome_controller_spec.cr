require "spec_helper"
require "../src/controllers/welcome_controller"

describe WelcomeController do
  describe "#index" do
    it "renders the welcome page" do
      get "/"
      expect(last_response.status_code).to eq(200)
    end
  end
end