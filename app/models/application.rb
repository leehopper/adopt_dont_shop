class Application < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :description, :zip_code
  validates :zip_code, numericality: {only_integer: true, greater_than: 1, less_than: 99999 }
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  has_many :shelters, through: :pets
  enum status: [ :in_progress, :pending, :accepted, :rejected ]

  def submit(new_description)
    update(description: new_description, status: 'pending')
  end

  def add_pet(new_pet)
    pets << Pet.find(new_pet)
  end

  def approved_pets
    pets.where('pet_applications.approval_status = ?', 1)
  end

  def denied_pets
    pets.where('pet_applications.approval_status = ?', 2)
  end

  def pending_pets
    pets.where('pet_applications.approval_status = ?', 0)
  end
end
