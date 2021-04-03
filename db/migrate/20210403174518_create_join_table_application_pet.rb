class CreateJoinTableApplicationPet < ActiveRecord::Migration[5.2]
  def change
    create_join_table :applications, :pets do |t|
      t.index [:application_id, :pet_id]
      # t.index [:pet_id, :application_id]
    end
  end
end
