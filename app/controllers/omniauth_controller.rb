class OmniauthController < ApplicationController
  def facebook
    begin
      if current_user # ログイン中に連携する
        if current_user.social_profiles.where(provider: "facebook").first.present?
          flash[:danger] = "すでにFacebookと連携されています。"
          redirect_to user_path(current_user)
        elsif social_profile = SocialProfile.find_by(uid: auth_hash[:uid])
          flash[:danger] = "すでに登録されているアカウントです。"
          redirect_to user_path(current_user)
        else
          social_profile = current_user.social_profiles.build
          social_profile.assign_auth_hash(auth_hash)
          social_profile.save!
          flash[:success] = "Facebookと連携しました。"
          redirect_to user_path(current_user)
        end
      else # ログインしてない時
        social_profile = SocialProfile.find_by(uid: auth_hash[:uid])
        if social_profile # ログイン処理
          user = User.find(social_profile.user_id)
          log_in(user)
          flash[:success] = "ようこそ！"
          redirect_to user_path(user)
        else # 新規登録
          user = User.new
          user.assign_auth_hash(auth_hash)
          if User.find_by(email: user.email)
            user = User.find_by(email: user.email)
            social_profile = user.social_profiles.build
            social_profile.assign_auth_hash(auth_hash)
            social_profile.save!
            user.save!(context: :omniauth)
            log_in(user)
            flash[:success] = "Facebookと連携しました。"
            redirect_to user_path(user)
          else
            social_profile = user.social_profiles.build
            social_profile.assign_auth_hash(auth_hash)
            # user.omniauth_sign_up = true
            user.save!(context: :omniauth)
            log_in(user)
            flash[:success] = "ご登録ありがとうございます。下記フォームから都道府県を登録してください。"
            redirect_to edit_user_path(user)
          end
        end
      end
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "このアカウントは登録/ログインできません"
      render_404
    end
  end

  def line
    begin
      if current_user # ログイン中に連携する
        if current_user.social_profiles.where(provider: "line").first.present?
          flash[:danger] = "すでにLINEと連携されています。"
          redirect_to root_path
        elsif social_profile = SocialProfile.find_by(uid: auth_hash[:uid])
          flash[:danger] = "すでに登録されているアカウントです。"
          redirect_to root_path
        else
          social_profile = current_user.social_profiles.build
          social_profile.assign_auth_hash(auth_hash)
          social_profile.save!
          flash[:success] = "LINEと連携しました。"
          redirect_to root_path
        end
      else # ログインしてない時
        social_profile = SocialProfile.find_by(uid: auth_hash[:uid])
        if social_profile # ログイン処理
          user = User.find(social_profile.user_id)
          log_in(user)
          flash[:success] = "ようこそ！"
          redirect_to root_path
        else # 新規登録
          user = User.new
          user.assign_auth_hash(auth_hash)
          social_profile = user.social_profiles.build
          social_profile.assign_auth_hash(auth_hash)
          # user.omniauth_sign_up = true
          user.save!(context: :omniauth)
          log_in(user)
          flash[:success] = "ご登録ありがとうございます。下記フォームからお名前・都道府県・メールアドレスを登録してください。"
          redirect_to root_path
        end
      end
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "このアカウントは登録/ログインできません"
      render_404
    end
  end

  def failure
    flash[:danger] = "何らかのエラーが発生しました。"
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth'].with_indifferent_access
  end
end
