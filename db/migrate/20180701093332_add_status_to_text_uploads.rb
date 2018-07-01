class AddStatusToTextUploads < ActiveRecord::Migration[5.2]
  def change
    add_column :text_uploads, :status, :string, default: :pending
  end
end
