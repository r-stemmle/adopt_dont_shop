class ApplicationsPetsController < ApplicationController

  def create
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:id])
    application.pets << pet
    redirect_to application_path(application)
  end

  def update
    application = Application.find(params[:application_id])
    pet = application.pets.find { |pet| pet.id == params[:id].to_i }
    if params[:status] == 'approve'
      pet.status = "Approved"
    else
      pet.status = "Rejected"
    end
    pet.save
    redirect_to admin_application_path(application)
  end
end
