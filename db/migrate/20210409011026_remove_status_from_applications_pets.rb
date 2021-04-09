class RemoveStatusFromApplicationsPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :applications_pets, :status, :string
  end
end
