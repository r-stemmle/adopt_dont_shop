class AddStatusToApplicationsPets < ActiveRecord::Migration[5.2]
  def change
    add_column :applications_pets, :status, :string, default: "Pending"
  end
end
