class Admin::ApplicationsController < ApplicationsController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    # @approved_pets = @application.approved_pets
  end
end
