class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]
  before_action :authorize, only: [:create, :edit, :new]
  before_action :set_variables
  # GET /members or /members.json
  def index

    query_string = @active_site  + " = true"
    @members = Member.where(query_string).order(:order)
  end

  # GET /members/1 or /members/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.require(:member).permit(:name, :title, :description, :startDate, :dental, :medical, :vision)
    end


    def set_variables
      @active_site = "medical"
      if params[:site] == "dental"
        @active_site = params[:site]
      end
      query_string = @active_site  + " = true"
      query_string = query_string + " and title <> 'Home'"
      @extra_pages = Page.where(query_string)
      @extra_pages = @extra_pages.sort_by &:order
    end


end
