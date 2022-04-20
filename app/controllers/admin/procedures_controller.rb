class Admin::ProceduresController < ApplicationController
  layout 'application'
  before_action :set_procedure, only: %i[ show edit update destroy ]
  before_action :authorize, only: [:index, :show, :create, :edit, :new]
  before_action :set_variables
  # GET /procedures or /procedures.json
  def index
    @procedures = Procedure.order(:order)
    render "procedures/index"


  end

  # GET /procedures/1 or /procedures/1.json
  def show
  end

  # GET /procedures/new
  def new
    @procedure = Procedure.new(:medical => true)
    @procedure.order = Procedure.maximum("order").to_i + 5
    render "new"
  end

  # GET /procedures/1/edit
  def edit

  end

  # POST /procedures or /procedures.json
  def create
    @procedure = Procedure.new(procedure_params)
    @procedure.picture.attach(params[:procedure][:picture])

    respond_to do |format|
      if @procedure.save
        format.html { redirect_to "/admin/procedures", notice: "Procedure was successfully created." }
        format.json { render :show, status: :created, location: @procedure }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /procedures/1 or /procedures/1.json
  def update
    respond_to do |format|
      if params[:deletePicture] == "1"
        @procedure.picture.purge
        # format.html { redirect_to @member, notice: "Picture Deleted" }
      end
      if @procedure.update(procedure_params)
        format.html { redirect_to "/admin/procedures", notice: "Procedure was successfully updated." }
        format.json { render :show, status: :ok, location: @procedure }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @procedure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /procedures/1 or /procedures/1.json
  def destroy
    @procedure.destroy
    respond_to do |format|
      format.html { redirect_to procedures_url, notice: "Procedure was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_procedure
      @procedure = Procedure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def procedure_params
      params.require(:procedure).permit(:name, :price, :description, :picture, :dental, :medical, :vision, :discount, :start, :stop, :order)
    end


    def set_variables
      @admin=true
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      @active_site = "medical"
      if params[:site] != nil
        @active_site = params[:site]
      end
      query_string = @active_site  + " = true"
      @extra_pages = Page.where(query_string)
      @extra_pages = @extra_pages.sort_by &:order
    end
end
