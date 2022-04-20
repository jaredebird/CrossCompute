class Admin::MembersController < ApplicationController
  layout 'application'
  before_action :set_member, only: %i[ show edit update destroy ]
  before_action :authorize, only: [:index, :show, :create, :edit, :new]
  before_action :set_variables
  # GET /members or /members.json
  def index
    @members = Member.order(:order)
    render "members/index"
  end

  # GET /members/1 or /members/1.json
  def show
    render "members/show"
  end

  # GET /members/new
  def new
    @member = Member.new(:medical => true)
    @member.order = Member.maximum("order").to_i + 5
    render "new"
  end

  # GET /members/1/edit
  def edit
        render "edit"
  end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)
    @member.picture.attach(params[:member][:picture])
    log = Log.new()
    log.type = "Create New Team Member"
    log.ip = request.remote_ip
    log.userName = @current_user.email
    log.new = new_log

    log.save

    puts "username is " + log.userName + "; Log Type is: " + log.type + "; IP Address is: " + log.ip + "New: " + log.new
    respond_to do |format|
      if @member.save
        format.html { redirect_to "/admin/members", notice: "Member was successfully created." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    log = Log.new()
    log.type = "Edit Team Member "
    log.ip = request.remote_ip
    log.userName = @current_user.email
    log.new = new_log
    log.original = original_log
    log.save
    respond_to do |format|
      if params[:deletePicture] == "1"
        @member.picture.purge
        # format.html { redirect_to @member, notice: "Picture Deleted" }
      end

      if @member.update(member_params)
        format.html { redirect_to "/admin/members", notice: "Member was successfully updated." }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: "Member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:name, :title, :description, :startDate, :dental, :medical, :vision, :picture, :order)

    end


    def set_variables
      @admin=true
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      @active_site = "medical"
      if params[:site] = "dental"
        @active_site = params[:site]
      end
      query_string = @active_site  + " = true"
      @extra_pages = Page.where(query_string)
      @extra_pages = @extra_pages.sort_by &:order
    end
def new_log
  logText = ""
  logText = "Name: " + @member.name
  logText = logText + ", Title: " + @member.title
  logText = logText + ", Description: " + @member.description
  logText = logText + ", Order: " + @member.order.to_s
  logText = logText + ", Medical: " + @member.medical.to_s
  logText = logText + ", Dental:" + @member.dental.to_s
  return logText
end

def original_log
  logText = ""
  logText = "Name: " + @member.name
  logText = logText + ", Title: " + @member.title
  logText = logText + ", Description: " + @member.description
  logText = logText + ", Order: " + @member.order.to_s
  logText = logText + ", Medical: " + @member.medical.to_s
  logText = logText + ", Dental:" + @member.dental.to_s
  return logText
end

end
