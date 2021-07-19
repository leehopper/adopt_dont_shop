class Admin::SheltersController < ApplicationController
  def index
    @all_shelters = Shelter.order_by_reverse_alphabet
    @shelters_with_pending_apps = Shelter.pending_apps.order_by_alphabet
  end
end
