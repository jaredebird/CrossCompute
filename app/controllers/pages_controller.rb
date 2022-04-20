class PagesController < ApplicationController
  before_action :set_page, only: %i[ show edit update destroy ]

  before_action :set_variables
  # GET /pages or /pages.json
  def index
    @pages = Page.all
  end

  # GET /pages/1 or /pages/1.json
  def show
    render "application/pages"
  end

  private

  def set_variables
    @active_site == "medical"
    if params[:site] = "dental"
      @active_site = params[:site]
    end

    query_string = "title <> 'Home'"
    @extra_pages = Page.where(query_string)
    @extra_pages = @extra_pages.sort_by &:order
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:title, :layout, :order, :dental, :medical, :vision)
    end
end
