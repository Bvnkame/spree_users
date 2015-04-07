class AddSignUpTypeToSpreeUser < ActiveRecord::Migration
  def change
  	add_column :spree_users, :signup_type, :string
  end
end
