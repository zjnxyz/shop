class AppleController < ApplicationController
  def index
  	@search=Application.search(params[:search])
    @applications =Application.where("is_handle = ?",false).page(params[:page]).per(5)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @applications }
    end
  end
end
