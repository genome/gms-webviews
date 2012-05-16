class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def render_404(exception)
    flash[:error] = exception.message
    respond_to do |type|
      type.html { render template: "errors/404", layout: 'application', status: 404 }
      type.all  { render nothing: true, status: 404 }
    end
  end

  def not_found(msg = "Not Found")
    raise ActiveRecord::RecordNotFound.new(msg)
  end

end
