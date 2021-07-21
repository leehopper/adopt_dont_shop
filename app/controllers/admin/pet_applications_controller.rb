class Admin::PetApplicationsController < ApplicationsController
  def update
    pet_application = PetApplication.locate_record(params[:id], params[:pet])

    if params[:status] == 'approved'
      pet_application.approve
    elsif params[:status] == 'denied'
      pet_application.deny
    end

    redirect_to "/admin/applications/#{params[:id]}"
  end
end
