class AddSourceTypeToTextUploads < ActiveRecord::Migration[5.2]
  def change
    add_column :text_uploads, :source_type, :string, null: false
  end
end
