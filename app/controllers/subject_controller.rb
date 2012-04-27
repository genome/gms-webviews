class SubjectController < ApplicationController

  def show
    @subject = SubjectPresenter.new(params[:id])
    case @subject.model_object
    when Genome::Taxon
      render 'taxon/show'
    else
      render 'subject/show'
    end
  end

end
