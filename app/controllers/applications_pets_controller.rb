class ApplicationsPetsController < ApplicationController

  def create
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:id])
    application.pets << pet
    redirect_to application_path(application)
  end

  def update
    application = Application.find(params[:application_id])
    pet = application.application_pet(params[:id].to_i)
    if params[:status] == 'approve'
      pet.status = "Approved"
      application.status = "Approved" if application.approved?
    else
      pet.status = "Rejected"
      application.status = "Rejected" if application.rejected?
    end
    pet.save
    application.save
    redirect_to admin_application_path(application)
  end
end
