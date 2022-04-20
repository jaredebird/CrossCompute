class DentalController < ApplicationController
before_action :set_variables

  def index

  end


def pages
  @page = Page.find(params[:id])
end

  def about

  end

  def set_variables
    @active_site = "medical"
    if params[:site] != nil
      @active_site = params[:site]
    end
    query_string = @active_site  + " = true"
    @extra_pages = Page.where(query_string)
    @extra_pages = @extra_pages.sort_by &:order
  end
end
