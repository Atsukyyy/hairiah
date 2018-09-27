class AppliesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def index

  end

  def show

  end

  def new
    @micropost = Micropost.find(params[:micropost_id])
    @apply = @micropost.applies.build
  end

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @apply = @micropost.applies.build(apply_params)
    @apply.user_id = current_user.id
    if @apply.save
      flash[:success] = "応募しました。美容師からの連絡をお待ち下さい。"
      redirect_to root_url
    else
      if Apply.find_by(user_id: current_user.id).present?
        flash[:danger] = "既にこの募集には応募済みです。応募履歴を確認してください。"
        redirect_to user_path(current_user)
      else
        flash.now[:danger] = "応募に失敗しました。画面を更新してからもう一度応募してください。"
        render 'new'
      end
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to request.referrer || root_url
    # /        => DELETE
    # /users/1 => DELETE
  end

  def apply

  end

  private

    def apply_params
      params.require(:apply).permit(:memo, :micropost_id, :user_id)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def staff_user
      redirect_to root_url unless current_user.staff == true
    end
end
