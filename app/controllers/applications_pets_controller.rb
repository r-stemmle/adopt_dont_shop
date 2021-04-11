class ApplicationsPetsController < ApplicationController

  def create
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:id])
    application.pets << pet
    redirect_to application_path(application)
  end

  def update
    application = Application.find(params[:application_id])
    line_item = application.application_pet(params[:id].to_i)
    if params[:status] == 'approve'
      line_item.status = "Approved"
      application.status = "Approved" if application.approved?
    else
      line_item.status = "Rejected"
      application.status = "Rejected" if application.rejected?
    end
    line_item.save
    application.save
    redirect_to admin_application_path(application)
  end

  # def update_application
  #   application.update_status
  #   update_pet if some scenario
  # end

  def update_pet
    pet.update_adoptable
  end




end
