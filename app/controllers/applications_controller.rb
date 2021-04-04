class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def new

  end

  def create
    @application = Application.create(application_params)

    if @application.valid?
      redirect_to application_path(@application)
    else
      redirect_to new_application_path
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end

  def show
    if params[:query]
      @application = Application.find(params[:id])
      @pet = Pet.search(params[:query])
      # binding.pry
    else
      @application = Application.find(params[:id])
    end

  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def application_params
    params.require(:application).permit(
                  :id,
                  :name,
                  :street,
                  :city,
                  :state,
                  :zip_code,
                  :justification,
                  :status)
  end
end
