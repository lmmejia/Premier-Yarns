class ApplicationController < ActionController::Base
  include CurrentCart

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :set_cart

  helper_method :current_user, :logged_in?, :admin?

  private
    def current_user
      return @current_user if defined?(@current_user)

      if session[:user_id]
        @current_user = User.find_by(id: session[:user_id])
        session.delete(:user_id) unless @current_user
      else
        @current_user = nil
      end

      @current_user
    end

    def logged_in?
      current_user.present?
    end

    def admin?
      current_user&.admin?
    end

    def require_login
      return if logged_in?

      session[:return_to] = request.fullpath
      flash[:notice] = "Please log in first."
      redirect_to access_login_path
    end

    def require_admin
      unless admin?
        flash[:notice] = "You are not authorized to perform that action."
        redirect_to shopper_path
      end
    end
end
