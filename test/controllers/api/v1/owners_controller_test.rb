require "test_helper"

class Api::V1::OwnersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.new(name: "Uzivatel", email: "uzivatel@seznam.cz",
                     password: "klukujeden", password_confirmation: "klukujeden")
  end

  def index

  end
end
