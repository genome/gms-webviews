class SubjectController < ApplicationController
  def show
    @subject = Subject.with_models_and_builds.find(params[:id])
  end
end
