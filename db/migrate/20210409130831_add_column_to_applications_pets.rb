class AddColumnToApplicationsPets < ActiveRecord::Migration[5.2]
  def change
    add_column :applications_pets, :id, :primary_key
  end
end
