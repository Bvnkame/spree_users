Spree::Api::ApiHelpers.class_eval do  
	def user_attributes
		[:id, :email, :created_at, :updated_at, :first_name, :last_name, :birthday, :signup_type]
	end
end