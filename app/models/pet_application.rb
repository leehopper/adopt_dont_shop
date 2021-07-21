class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  enum approval_status: [ :pending, :approved, :denied ]

  def self.locate_record(application_id, pet_id)
    where(application_id: application_id, pet_id: pet_id).first
  end

  def approve
    update(approval_status: 'approved')
  end

  def deny
    update(approval_status: 'denied')
  end
end
