class UserController < ApplicationController
  def show
    @user = User.where(email: "acoffman@genome.wustl.edu")
  end
end
