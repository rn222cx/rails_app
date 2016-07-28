class StaticController < ApplicationController
  def help
    @dog = Dogs.new("bibs", 13)
  end

  def index

  end
end
