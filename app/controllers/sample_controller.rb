class SampleController < ApplicationController
  def show
    @subject = SubjectPresenter.new(params[:id], controller: :taxon)
    render 'subject/show'
  end
end
