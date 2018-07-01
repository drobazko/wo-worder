class CreateTextUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :text_uploads do |t|
      t.string :h, null: false
      t.string :upload_source, null: false

      t.timestamps
    end
  end
end
