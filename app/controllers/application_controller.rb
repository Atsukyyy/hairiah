class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    def staff_user
      unless current_user.staff?
        store_location
        flash[:danger] = "美容師としてログインしてください。"
        redirect_to login_url
      end
    end

    # モデルは全スタッフを見れる、自分以外のモデルは見れない
    # スタッフは全モデルを見れる、自分以外のスタッフは見れない
    def staff_or_correct_user
      user = User.find(params[:id])
      if !user.staff?
        unless current_user.staff? || current_user?(user)
          redirect_to(root_url)
        end
      else
        if current_user.staff? && !current_user?(user)
          redirect_to root_url
        end
      end

    end

    def only_model_to_staff

    end

    def correct_user
      user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(user)
    end
end
