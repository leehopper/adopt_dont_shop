class Admin::ApplicationsController < ApplicationsController
  def show
    @application = Application.find(params[:id])
    @all_pets = @application.pets
    @approved_pets = @application.approved_pets
    @denied_pets = @application.denied_pets
    @application.approve?
  end
end
