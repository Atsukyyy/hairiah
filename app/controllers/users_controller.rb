class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :staff_index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :staff_user, only: [:index]
  before_action :only_model_to_staff, only: [:show]
  before_action :staff_or_correct_user, only: [:show]
  before_action :correct_user, only: [:edit, :update, :password]

  def index
    @model_users = User.where(staff: false)
    @search = @model_users.ransack(params[:q])
    @users = @search.result(distinct: true).order(id: :desc).paginate(page: params[:page], per_page: 20 )

  end

  def staff_index
    @staff_users = User.where(staff: true)
    @search = @staff_users.ransack(params[:q])
    @users = @search.result(distinct: true).order(last_accessed_at: :desc).paginate(page: params[:page], per_page: 20 )

  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
    @messages_history = Message.where(from_id: @user.id).or(Message.where(to_id: @user.id)).reverse_order.uniq{|h| [h[:from_id],h[:to_id]]}
    ids = []
    @messages_history.each do |message|
      ids << message.to_id unless message.to_id == @user.id
      ids << message.from_id unless message.from_id == @user.id
    end
    @message_users = User.where(id: ids)
  end


  def new
    @user = User.new
  end

  def staff_new
    @user = User.new
  end

  def create
    area = Area.find(params[:user][:area_id])
    prefecture = area.prefecture
    @user = area.users.build(user_params)
    @user.prefecture = prefecture
    @user.last_accessed_at = Time.now
    @user.calc_age
    if @user.save
      @user.send_activation_email
      flash[:info] = "メールを送信しました。ユーザー認証のためにご確認ください。メール送信に1〜2分かかることがあります。"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def staff_create
    area = Area.find(params[:user][:area_id])
    prefecture = area.prefecture
    @user = area.users.build(user_params)
    @user.prefecture = prefecture
    @user.staff = true
    @user.calc_age
    if @user.save
      @user.send_activation_email
      flash[:info] = "メールを送信しました。ユーザー認証のためにご確認ください。メール送信に1〜2分かかることがあります。"
      redirect_to root_url
    else
      render 'staff_new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def password
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "情報を更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def confirm
    @user = current_user
  end

  def destroy
    @user = User.find(params[:id])
    @user.soft_delete!
    session.delete(:user_id)
    flash[:danger] = "退会しました。"
    redirect_to root_path
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :name, :password, :password_confirmation, :birth, :sex, :color, :hair_extension, :nail, :use, :prefecture_id, :hair_type, :area_id, :hair_style, :image, :remove_image, :fb_sign_up, :g_sign_up, :hair_permed)
    end

end
