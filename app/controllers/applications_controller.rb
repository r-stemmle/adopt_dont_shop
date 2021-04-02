class ApplicationsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
    @application = Application.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
