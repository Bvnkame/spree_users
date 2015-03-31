Spree::Api::UsersController.class_eval do
	include Spree::OrdersImporter
	before_action :authenticate_user, :except => [:create]

	def create
		@user = Spree.user_class.new(user_params)
		if @user.save
			sign_in(@user)
			@order = find_cart_order_login(@user)
			unless @order
				@order = create_order(@user)
			end
			@user.generate_spree_api_key!
			render "spree/api/users/show", status: 200
		else
			invalid_resource!(@user)
		end
	end

end