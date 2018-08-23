class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :staff_index, :show, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    #@users = User.all
    @users = User.where(staff: false).paginate(page: params[:page], per_page: 20)

    if params[:last_name].present?
      @users = @users.get_by_name params[:last_name]
    end
    if params[:age_from].present? && params[:age_to].present?
      if params[:age_from].present? && params[:age_to].present?
        if params[:age_from] < params[:age_to]
          @users = @users.get_by_age(params[:age_from], params[:age_to])
        else
          @users = @users.get_by_age(params[:age_to], params[:age_from])
        end
      elsif params[:age_from].present? && params[:age_to].empty?
        flash.now[:danger] = "年齢欄を使用するときは両方に値を入力してください。"
        render 'index'
      elsif params[:age_from].empty? && params[:age_to].present?
        flash.now[:danger] = "年齢欄を使用するときは両方に値を入力してください。"
        render 'index'
      end
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
      @users = @users.get_by_color params[:color]
    end
    if params[:hair_extension].present?
      @users = @users.get_by_hair_extension params[:hair_extension]
    end
    if params[:nail].present?
      @users = @users.get_by_nail params[:nail]
    end
    if params[:advertisement].present?
      @users = @users.get_by_advertisement params[:advertisement]
    end
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
    @thumbnails = @user.thumbnails

  end

  # GET /users/new
  def new
    @user = User.new
    # => form_for @user
    3.times { @user.thumbnails.build }
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
    @user.age = @user.age
    if @user.save # => Validation
      # Sucess
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
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
    @user.age = @user.age
    @user.staff = true
    if @user.save # => Validation
      # Sucess
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
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
    if @user.thumbnails.count == 1
      2.times { @user.thumbnails.build }
    elsif @user.thumbnails.count == 2
      2.times { @user.thumbnails.build }
    elsif @user.thumbnails.count == 0
      3.times { @user.thumbnails.build }
    end
  end

  #PATCH /users/:id
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Success
      flash[:success] = "Profile updated"
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
      params.require(:user).permit(:email, :name, :last_name, :first_name, :password, :password_confirmation, :birth, :sex, :color, :hair_extension, :nail, :advertisement, :prefecture_id, :hair_type, :area_id, :hair_style, :thumbnail_cache,  thumbnails_attributes: [:id, :image, :_destroy])
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
