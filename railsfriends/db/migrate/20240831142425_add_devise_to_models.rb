# frozen_string_literal: true

class AddDeviseToModels < ActiveRecord::Migration[7.1]
  def self.up
    change_table :models do |t|
      # Only add columns that do not exist yet
      unless column_exists?(:models, :encrypted_password)
        t.string :encrypted_password, null: false, default: ""
      end

      unless column_exists?(:models, :reset_password_token)
        t.string   :reset_password_token
        t.datetime :reset_password_sent_at
      end

      unless column_exists?(:models, :remember_created_at)
        t.datetime :remember_created_at
      end

      # Add more columns conditionally as needed
      # ...

      # Add indexes if they don't already exist
      unless index_exists?(:models, :reset_password_token)
        add_index :models, :reset_password_token, unique: true
      end

      unless index_exists?(:models, :email)
        add_index :models, :email, unique: true
      end
    end
  end

  def self.down
    change_table :models do |t|
      # Remove columns that were added in the up method
      t.remove :encrypted_password
      t.remove :reset_password_token
      t.remove :reset_password_sent_at
      t.remove :remember_created_at

      # Remove indexes if they were added
      remove_index :models, :reset_password_token if index_exists?(:models, :reset_password_token)
      remove_index :models, :email if index_exists?(:models, :email)
    end
  end
end
