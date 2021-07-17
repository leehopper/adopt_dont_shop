class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications
  enum status: [ :in_progress, :pending, :accepted, :rejected ]
end
