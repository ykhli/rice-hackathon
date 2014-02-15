class CreateRooms < ActiveRecord::Migration
  def up
    create_table :rooms do |t|
      t.string :name,   null: false

      t.timestamps
    end
  end

  def down
    drop_table :rooms
  end
end
