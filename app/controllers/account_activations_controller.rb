class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      # Success => Signup
      user.activate
      log_in user
      flash[:success] = "ユーザー認証が完了しました！"
      redirect_to user
    else
      # Failure
      flash[:danger] = "不正な認証リンクです。"
      redirect_to root_url
    end
  end
end
