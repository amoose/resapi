class SessionsController < ApplicationController

  def new
    # if user = User.find_by_nickname(cookies.signed[:nickname])
    #   setup_signed_in_session(user)
    #   redirect_to root_url, :notice => "Welcome back, #{user.name}"
    # else
    redirect_to '/auth/github'
    # end
  end


  def create
    auth = request.env["omniauth.auth"]
    reset_session
    existing_authentication = Authentication.where(:provider => auth[:provider], :uid => auth[:uid].to_s).first
    if existing_authentication and user = existing_authentication.user
      session[:return_user] = true
    else
      user = User.create_with_omniauth(auth)
      session[:new_signup] = true
    end

    # Reset the session after successful login, per
    # 2.8 Session Fixation – Countermeasures:
    # http://guides.rubyonrails.org/security.html#session-fixation-countermeasures

    setup_signed_in_session(user)
    if user.email.blank?
      redirect_to edit_user_path(user), :notice => "Please enter your email address."
    elsif cookies[:redirect_to]
      path = cookies[:redirect_to]
      cookies.delete(:redirect_to)
      redirect_to path, :notice => "Welcome back, #{user.name}"
    else
      cookies.delete(:redirect_to)
      redirect_to root_url, :notice => "Welcome back, #{user.name}"
    end

  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    @message = params[:message] || "unauthorized"
    redirect_to root_url, :alert => "Authentication error: #{@message.humanize}"
  end

  def update_geolocation
    begin
      session[:geolocation] = { 
        :latitude => params[:latitude],
        :longitude => params[:longitude],
        :updated_at => DateTime.now,
        :accuracy => params[:accuracy] || 0
      }
      render :json => { :status => :success }.merge(session[:geolocation])
    rescue
      render :json => { :status => :error }
    end
  end

  private
    def setup_signed_in_session(user)
      session[:user_id] = user.id
      user.last_ip = request.ip
      user.save
      cookies.permanent.signed[:username] = user.username
    end

end
