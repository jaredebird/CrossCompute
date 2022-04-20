class Admin::PagesController < ApplicationController
  layout 'application'
  before_action :set_page, only: %i[ show edit update destroy ]
    before_action :authorize, only: [:index, :show, :create, :edit, :new]
  before_action :set_variables
  # GET /pages or /pages.json
  def index

    @pages = Page.order(:order)

    render "pages/index"
  end

  # GET /pages/1 or /pages/1.json
  def show
    render "application/pages"
  end

  # GET /pages/new
  def new
    @page = Page.new(:medical => true)
    @page.order = Page.maximum("order").to_i + 5
    render "new"

  end

  # GET /pages/1/edit
  def edit
    render "edit"
  end

  # POST /pages or /pages.json
  def create
    @page = Page.new(page_params)
    @page.top_picture.attach(params[:page][:top_picture])
    @page.left_picture.attach(params[:page][:left_picture])
    @page.right_picture.attach(params[:page][:right_picture])
    @page.bottom_picture.attach(params[:page][:bottom_picture])

    respond_to do |format|
      if @page.save
        format.html { redirect_to "/admin/pages/#{@page.id}/edit", notice: "Page was successfully created." }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1 or /pages/1.json
  def update

    if params[:deleteTopPicture] == "1"
      @page.top_picture.purge
    end
    if params[:deleteLeftPicture] == "1"
      @page.left_picture.purge
    end
    if params[:deleteRightPicture] == "1"
      @page.right_picture.purge
    end
    if params[:deleteBottomPicture] == "1"
      @page.bottom_picture.purge
    end


    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to "/admin/pages/#{@page.id}/edit", notice: "Page was successfully updated." }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: "Page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:title, :layout, :order, :dental, :medical, :vision, :top_picture, :left_picture, :right_picture, :bottom_picture)
    end

    def set_variables
      @admin=true
      @current_user ||= User.find(session[:user_id]) if session[:user_id]

      
      @extra_pages = Page.order(:order)
      @extra_pages = @extra_pages.sort_by &:order
    end
end
