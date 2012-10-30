class SampleController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: SamplesDatatable.new(view_context) }
    end
  end

  def show
    subject = Genome::Subject.find(params[:id])
    @subject = SubjectPresenter.new(subject)
    render 'subject/show'
  end
end
