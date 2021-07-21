class Admin::SheltersController < ApplicationController
  def index
    @all_shelters = Shelter.order_by_reverse_alphabet
    @shelters_with_pending_apps = Shelter.pending_apps.order_by_alphabet
  end

  def show
    #raw sequel as practice per project user story instructions
    @attributes = Shelter.find_by_sql([ "SELECT name, city FROM shelters WHERE id = ? LIMIT 1;", "#{params[:id]}" ]).first

    shelter = Shelter.find(params[:id])
    @adoptable_average_age = shelter.adoptable_average_age
  end
end
