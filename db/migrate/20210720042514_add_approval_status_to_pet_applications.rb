class AddApprovalStatusToPetApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_applications, :approval_status, :integer, default: 0
  end
end
