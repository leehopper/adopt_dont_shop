class Admin::ApplicationsController < ApplicationsController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end
end
