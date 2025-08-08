class AddAgreedToPolicyToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :agreed_to_policy, :boolean
  end
end
