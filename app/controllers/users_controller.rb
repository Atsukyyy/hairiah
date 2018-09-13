class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :staff_index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    #@users = User.all
    @users = User.where(staff: false).paginate(page: params[:page], per_page: 20)

    if params[:name].present?
      @users = @users.get_by_name params[:name]
    end
    if params[:age].present?
      @users = @users.get_by_age params[:age]
    end
    if params[:sex].present?
      @users = @users.get_by_sex params[:sex]
    end
    if params[:prefecture_id].present?
      @users = @users.get_by_prefecture_id params[:prefecture_id]
    end
    if params[:area_id].present?
      @users = @users.get_by_area_id params[:area_id]
    end
    if params[:color].present?
      bool = ActiveRecord::Type::Boolean.new.cast(params[:color])
      @users = @users.get_by_color bool
    end
    if params[:hair_extension].present?
      bool = ActiveRecord::Type::Boolean.new.cast(params[:hair_extension])
      @users = @users.get_by_hair_extension bool
    end
    if params[:nail].present?
      bool = ActiveRecord::Type::Boolean.new.cast(params[:nail])
      @users = @users.get_by_nail bool
    end
    if params[:reason].present?
      @users = @users.get_by_reason params[:reason]
    end
    render 'index'
  end

  def staff_index
    @users = User.where(staff: true).paginate(page: params[:page])
  end

  # GET /users/:id
  def show
    @user       = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    # => app/views/users/show.html.erb
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
    # @thumbnails = @user.thumbnails
    @messages_history = Message.where(from_id: @user.id).or(Message.where(to_id: @user.id)).reverse_order.uniq{|h| [h[:from_id],h[:to_id]]}
    ids = []
    @messages_history.each do |message|
      ids << message.to_id unless message.to_id == @user.id
      ids << message.from_id unless message.from_id == @user.id
    end

    @message_users = User.where(id: ids)

  end

  # GET /users/new
  def new
    @user = User.new
    # => form_for @user
  end

  def staff_new
    @user = User.new
  end

  # POST /users
  def create
    area = Area.find(params[:user][:area_id])
    prefecture = area.prefecture
    @user = area.users.build(user_params)
    @user.prefecture = prefecture
    @user.last_accessed_at = Time.now
    if @user.save # => Validation
      # Sucess
      @user.send_activation_email
      flash[:info] = "メールを送信しました。ユーザー認証のためにご確認ください。メール送信に1〜2分かかることがあります。"
      redirect_to root_url
    else
      # Failure
      render 'new'
    end
  end

  def staff_create
    area = Area.find(params[:user][:area_id])
    prefecture = area.prefecture
    @user = area.users.build(user_params)
    @user.prefecture = prefecture
    @user.staff = true
    if @user.save # => Validation
      # Sucess
      @user.send_activation_email
      flash[:info] = "メールを送信しました。ユーザー認証のためにご確認ください。メール送信に1〜2分かかることがあります。"
      redirect_to root_url
    else
      # Failure
      render 'staff_new'
    end
  end

  # GET /users/:id/edit
  # params[:id] => :id
  def edit
    @user = User.find(params[:id])

  end

  def password
    @user = User.find(params[:id])
  end

  #PATCH /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Success
      flash[:success] = "情報を更新しました。"
      redirect_to @user
    else
      # Failure
      # => @user.errors.full_messages()
      render 'edit'
    end
  end

  # DELETE /users/:id
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
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

    # 正しいユーザーかどうか確認
    def correct_user
      # GET   /users/:id/edit
      # PATCH /users/:id
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
