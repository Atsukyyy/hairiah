class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
    render layout: "application_not_container"
  end

  def usage
  end

  def staff_usage
  end

  def help
  end

  def about
  end

  def contact
  end

  def privacy_polic
  end

  def term
  end

  def signup_pag
  end

  def google_auth_html
    render file: 'google06c94e3e8ca4cac4.html', layout: false, content_type: 'text/html'
  end

  def legal
  end
end
