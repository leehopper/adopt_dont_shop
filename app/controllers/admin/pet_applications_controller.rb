class Admin::PetApplicationsController < ApplicationsController
  def update
    pet_application = PetApplication.where(application_id: params[:id], pet_id: params[:pet])

    pet_application.update(approval_status: params[:status])
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
