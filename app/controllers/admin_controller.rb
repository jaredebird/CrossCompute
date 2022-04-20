class AdminController < ApplicationController

  layout 'application'
  before_action :set_variables


  def members
    @members = Member.all
    render "members/index"
  end
  def members_edit
    @member = Member.find(params[:id])
    render "members/edit"
  end



def set_variables
      @admin=true
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

end
