module Spree
	class LogUserController < Spree::Api::BaseController
		before_action :authenticate_user, :except => [:login]

		def login
			@user = Spree.user_class.find_for_database_authentication(:email => params[:email])
			if  @user &&  @user.valid_password?(params[:password])
				sign_in(@user)
				@user.generate_spree_api_key!
				render "spree/api/users/show"
			else
				respond_to do |format|
					format.json { render :json => { "error " =>  "Email or Password is wrong" }, :status => 404}
				end
			end
		end

		def logout
			@user = Spree.user_class.find_for_database_authentication(:spree_api_key => request.headers['X-Spree-Token'])
			if @user
				sign_out(@user)
				@user.generate_spree_api_key!
				respond_to do |format|
					format.json { render :json => { "message " =>  "Logout Successful" }, :status => 200}
				end
			else
				respond_to do |format|
					format.json { render :json => { "message " =>  "API-Key isn't valuable" }, :status => 404}
				end
			end
		end
	end
end
