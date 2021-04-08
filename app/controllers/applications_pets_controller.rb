class ApplicationsPetsController < ApplicationController

  def create
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:id])
    application.pets << pet
    redirect_to application_path(application)
  end
end
