class ProceduresController < ApplicationController
  before_action :set_procedure, only: %i[ show edit update destroy ]
  before_action :authorize, only: [:create, :edit, :new]
  before_action :set_variables
  # GET /procedures or /procedures.json
  def index

    query_string = @active_site  + " = true"
    @procedures = Procedure.where(query_string).order(:order)

  end

  # GET /procedures/1 or /procedures/1.json
  def show

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def procedure_params
      params.require(:procedure).permit(:name, :price, :description, :picture, :dental, :medical, :vision, :discount, :start, :stop)
    end


    def set_variables
      @active_site = "medical"
      if params[:site] != nil
        @active_site = params[:site]
      end
      query_string = @active_site  + " = true"
      query_string = query_string + " and title <> 'Home'"
      @extra_pages = Page.where(query_string)
      @extra_pages = @extra_pages.sort_by &:order
    end
end
