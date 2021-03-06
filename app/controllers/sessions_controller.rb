class SessionsController < ApplicationController

  # GET /login
  def new
    #@session = Session.new
  end

  # POST /login
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        # Success
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        user.last_accessed_at = Time.now
        user.save!
        flash[:success] = "ログインしました。"
        redirect_back_or user
      else
        message  = "まだユーザー認証が完了していません。"
        message += "受信メールのリンクから認証を行ってください。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # Failure
      flash.now[:danger] = 'メールアドレスとパスワードの組み合わせが正しくありません。'
      render 'new'
    end
  end

  # DELETE /logout
  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
end
