class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :text
      t.string :image_url
      t.integer :group_id
      t.timestamps
    end
  end
end
