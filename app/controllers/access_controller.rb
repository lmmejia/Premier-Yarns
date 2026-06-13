class AccessController < ApplicationController
  def login
  end

  def authenticate
    user = User.find_by(userid: params[:userid])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session.delete(:return_to).presence || shopper_path, notice: "Welcome, #{user.userid}!"
    else
      flash[:notice] = "Login failed"
      redirect_to access_login_path
    end
  end

  def logout
    session.delete(:user_id)
    session.delete(:cart_id)
    flash[:notice] = "Logged out"
    redirect_to access_login_path
  end

  def signup
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to session.delete(:return_to).presence || shopper_path, notice: "Account created. Welcome, #{@user.userid}!"
    else
      render :signup, status: :unprocessable_content
    end
  end

  private
    def user_params
      params.expect(user: [ :userid, :email, :password, :password_confirmation ])
    end
end
