class RemoveStatusFromPets < ActiveRecord::Migration[5.2]
  def change
    remove_column :pets, :status, :string
  end
end
