class Admin::PetApplicationsController < ApplicationsController
  def update
    pet_application = PetApplication.locate_record(params[:id], params[:pet])

    if pet_application.approve
      redirect_to "/admin/applications/#{params[:id]}"
    else
      redirect_to "/admin/applications/#{params[:id]}"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end 
  end
end
