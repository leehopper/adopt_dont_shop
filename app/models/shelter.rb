class Shelter < ApplicationRecord
  validates :name, presence: true
  validates :rank, presence: true, numericality: true
  validates :city, presence: true

  has_many :pets, dependent: :destroy
  has_many :applications, through: :pets

  def self.order_by_recently_created
    order(created_at: :desc)
  end

  def self.order_by_number_of_pets
    select("shelters.*, count(pets.id) AS pets_count")
      .joins("LEFT OUTER JOIN pets ON pets.shelter_id = shelters.id")
      .group("shelters.id")
      .order("pets_count DESC")
  end

  def self.order_by_reverse_alphabet
    find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def self.order_by_alphabet
    order(:name)
  end

  def self.pending_apps
    joins(:applications).where('applications.status = ?', 1).distinct
  end

  def pet_count
    pets.count
  end

  def adoptable_pet_count
    adoptable_pets.count
  end

  def adoptable_pets
    pets.where(adoptable: true)
  end

  def pets_adopted_count
    pets.joins(:applications).where('applications.status = ?', 2).distinct.count
  end

  def alphabetical_pets
    adoptable_pets.order(name: :asc)
  end

  def shelter_pets_filtered_by_age(age_filter)
    adoptable_pets.where('age >= ?', age_filter)
  end

  def adoptable_average_age
    if adoptable_pets.count > 0
      adoptable_pets.average(:age).round().to_int
    else
      0
    end
  end
end
