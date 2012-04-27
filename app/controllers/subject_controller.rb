class SubjectController < ApplicationController

  def show
    @subject = SubjectPresenter.new(params[:id])
  end

end
