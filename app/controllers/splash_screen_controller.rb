class SplashScreenController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    # empty
  end
end
