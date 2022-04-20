class ApplicationController < ActionController::Base
  before_action :set_variables

  def index
    @active_site = "medical"
    if params[:site] != nil
      @active_site = params[:site]
    end
    query_string = ""
    #query_string = @active_site  + " = true"
    query_string = query_string + "title = 'Home'"


    #@page = Page.find_by title: 'Home',
    puts query_string
    @page = Page.where(query_string).first
    puts "Page Output = " + @page.to_s
    if @page.nil?
      @page = Page.first
    end
    render "application/pages"
  end

  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to login_path, alert: 'You must be logged in to access this page.' if current_user.nil?
  end

  def pages
      @page = Page.find(params[:id])
  end
  def members

  end

  def set_variables
    @active_site = "medical"
    if params[:site] == "dental"
      @active_site = params[:site]
    end
    query_string = ""
    #query_string = @active_site  + " = true"
    query_string = query_string + "title <> 'Home'"
    @extra_pages = Page.where(query_string)
    @extra_pages = @extra_pages.sort_by &:order
  end

end
