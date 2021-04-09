class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    if params[:form] == "approve"
      application = Application.find(params[:id])
      application.status = "Approved"
      application.save
    elsif params[:form] == "reject"
      application = Application.find(params[:id])
      application.status = "Rejected"
      application.save
    end
    redirect_to "/admin/applications/#{application.id}"
  end
end
