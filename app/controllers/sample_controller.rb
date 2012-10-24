class SampleController < ApplicationController
  def show
    subject = Genome::Subject.find(params[:id])
    @subject = SubjectPresenter.new(subject)
    render 'subject/show'
  end
end
