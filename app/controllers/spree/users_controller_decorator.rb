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

	def show
		@user ||= Spree.user_class.accessible_by(current_ability, :read).find(params[:id])
		render "spree/api/users/show_detail", status: 200
	end

	def update
		@user ||= Spree.user_class.accessible_by(current_ability, :read).find(params[:id])
		authorize! :update, @user
		if @user.update(user_update_params)
			render "spree/api/users/show_detail", status: 200
		else
			invalid_resource!(@user)
		end
	end

	def user_account
		@user = current_api_user
		render "spree/api/users/user_account", status: 200
	end

	def change_password
		p password_params
		p password_params[:old]
		p password_params[:new]
		@user = current_api_user
		authorize! :update, @user
	end

	def user_update_params
		params.require(:user).permit(:first_name, :last_name, :birthday)
	end

	def password_params
	 	params.require(:password).permit(:old, :new)
	 end 

end