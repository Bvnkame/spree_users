Spree::Api::UsersController.class_eval do
	include Spree::OrdersImporter
	before_action :authenticate_user, :except => [:create]

	def create
		p user_params
		@tam = Spree::User.new(user_params)
		@tam.save
		p "dfsdkf"
		p @tam
		@user = Spree.user_class.new(user_params)
		p @user
		if @user.save
			p @user
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
		@user = current_api_user
		authorize! :update, @user

		if @user.valid_password?(password_params[:old])
			@user.password = password_params[:new]
			@user.save
			p @user.password
			@status = [ { "messages" => "Update Password Successful"}]
			render "spree/api/logger/log", status: 200	
		else
			@status = [ { "messages" => "Password Is Not Right"}]
			render "spree/api/logger/log", status: 404	
		end
		
	end

	def user_update_params
		params.require(:user).permit(:first_name, :last_name, :birthday)
	end

	def password_params
		params.require(:password).permit(:old, :new)
	end 

end