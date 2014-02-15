class CreateContainers < ActiveRecord::Migration
  def up
    create_table :containers do |t|
      t.string  :name,    null: false
      t.integer :room_id, null: false

      t.timestamps
    end
  end

  def down
    drop_table :containers
  end
end
