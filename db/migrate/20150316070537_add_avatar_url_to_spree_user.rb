class AddAvatarUrlToSpreeUser < ActiveRecord::Migration
  def change
    add_column :spree_users, :avatar_url, :string
  end
end
