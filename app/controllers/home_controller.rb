class HomeController < ApplicationController
  def index
  	@question = Question.new
  end
end
