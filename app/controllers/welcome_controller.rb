class WelcomeController < ApplicationController
  def index
    render json: { message: "welcome home" }
  end
end
