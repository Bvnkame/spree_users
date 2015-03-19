Spree::Api::ApiHelpers.class_eval do  
	def user_attributes
		[:id, :email, :created_at, :updated_at, :first_name, :last_name, :birthday]
	end

	def product_attributes
		[
			:id, :name, :price, :display_price, :available_on,
			:slug, :meta_description, :meta_keywords, :shipping_category_id,
			:taxon_ids, :total_on_hand
		]
	end
end
