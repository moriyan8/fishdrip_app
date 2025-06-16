class AddActivationToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :activation_state, :string
    add_column :users, :activation_token, :string
    add_column :users, :activation_token_expires_at, :datetime

    add_index :users, :activation_token
  end
end
