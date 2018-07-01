class CreateWords < ActiveRecord::Migration[5.2]
  def change
    create_table :words do |t|
      t.references :text_upload
      t.string :w, null: false
      t.integer :count, null: false, default: 0 

      t.timestamps
    end

    add_index :words, :w
  end
end
