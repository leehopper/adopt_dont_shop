class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_results = :none
    if params[:search].present?
      @pet_results = Pet.search(params[:search])
    elsif params[:pet].present?
      @application.add_pet(params[:pet])
    elsif params[:description].present?
      @application.submit(params[:description])
    end
  end

  def new
  end

  def create
    application = Application.create(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code)
  end
end
