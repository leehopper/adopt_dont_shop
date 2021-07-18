class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zip_code
  validates :zip_code, numericality: {only_integer: true, greater_than: 1, less_than: 99999 }
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  enum status: [ :in_progress, :pending, :accepted, :rejected ]

  def submit(new_description)
    update_attributes(:description => new_description, :status => 'pending')
  end

  def add_pet(new_pet)
    pets << Pet.find(new_pet)
  end
end
