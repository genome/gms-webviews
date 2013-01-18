class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  #before_filter :authorize_user

  def render_404(exception)
    flash.now[:error] = exception.message
    respond_to do |type|
      type.html { render template: "errors/404", layout: 'application', status: 404 }
      type.all  { render nothing: true, status: 404 }
    end
  end

  def not_found(msg = "Not Found")
    raise ActiveRecord::RecordNotFound.new(msg)
  end

  private
    def authorize_user
      session[:current_user] ||= WebUser.current_user( request )
      @current_user = session[:current_user]
    end

end
