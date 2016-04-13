class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?
  helper_method :current_user_latlon

  before_filter :default_request_city
  before_filter :set_user_party

  def default_request_city
  	@request_city = request.location.city.blank? ? "Washington, D.C." : request.location.city
  end

  private
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Exception => e
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.friendly.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    def current_user_latlon
      session[:geolocation] ? "#{session[:geolocation][:latitude]},#{session[:geolocation][:longitude]}" : nil
    end

    def set_user_party
      @party_id = begin; @data_source.id; rescue; nil end
    end

end
