class AddIntroSeenToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :intro_seen, :boolean, default: false, null: false
  end
end
