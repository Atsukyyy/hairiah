class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy
  before_action :staff_user, only: [:new, :create, :destroy]

  def index
    @microposts = Micropost.all
  end

  def show
    @micropost = Micropost.find(params[:id])
    @applies = @micropost.applies
    @users = []
    @applies.each do |apply|
      @users << User.find(apply.user_id)
    end
  end

  def new
    @micropost = current_user.microposts.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿しました。ユーザーからの応募をお待ち下さい。"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
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

    def micropost_params
      params.require(:micropost).permit(:content, :picture, :area_id, :prefecture_id, :color, :hair_extension, :mens, :reason)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def staff_user
      redirect_to root_url unless current_user.staff == true
    end
end
