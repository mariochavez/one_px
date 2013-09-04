class HomeController < ApplicationController

  # Index action, list a set of resources
  def index
    @time = DateTime.now
  end
end
