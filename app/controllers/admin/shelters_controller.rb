class Admin::SheltersController < ApplicationController
  def index
    @all_shelters = Shelter.order_by_reverse_alphabet
    @shelters_with_pending_apps = Shelter.pending_apps.order_by_alphabet
  end

  def show
    #raw sequel as practice per project user story instructions
    @attributes = Shelter.find_attributes(params[:id])

    shelter = Shelter.find(params[:id])
    @adoptable_average_age = shelter.adoptable_average_age
    @total_adoptable_pets = shelter.adoptable_pet_count
    @total_pets_adopted = shelter.pets_adopted_count
  end
end
