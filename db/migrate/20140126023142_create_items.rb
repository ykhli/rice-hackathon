class CreateItems < ActiveRecord::Migration
  def up
    create_table :items do |t|
      t.string  :name,          null: false
      t.integer :container_id,  null: false

      t.timestamps
    end
  end

  def down
    drop_table :items
  end
end
