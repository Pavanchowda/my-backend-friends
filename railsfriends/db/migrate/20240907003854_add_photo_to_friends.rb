class AddPhotoToFriends < ActiveRecord::Migration[7.1]
  def change
    add_reference :friends, :photo, foreign_key: { to_table: :active_storage_blobs }, null: true
  end
end
