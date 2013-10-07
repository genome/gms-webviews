class TaxonController < ApplicationController
  def show
    subject = Genome::Subject.where(subject_id: params[:id]).first
    @subject = SubjectPresenter.new(subject)
    render 'subject/show'
  end
end
