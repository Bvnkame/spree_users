module Spree
	class LogUserController < Spree::Api::BaseController
		before_action :authenticate_user, :except => [:login]

		def login
			@user = Spree.user_class.find_for_database_authentication(:email => params[:email])
			if  @user 
				if @user.valid_password?(params[:password])
					sign_in(@user)
					@user.generate_spree_api_key!
					render "spree/api/users/show"
				else		
					@status = [ { "message" => "The password you entered is incorrect. Please try again!"}]
					render "spree/api/logger/log"
				end
			else
				@status = [ { "message" => "The email you entered is not on any account."}]
				render "spree/api/logger/log"
			end
		end

		def logout
			@user = Spree.user_class.find_for_database_authentication(:spree_api_key => request.headers['X-Spree-Token'])
			if @user
				sign_out(@user)
				@user.generate_spree_api_key!
				# respond_to do |format|
				# 	format.json { render :json => { "message " =>  "Logout Successful" }}
				# end
				@status = [ { "message" => "Logout successful"}]
				render "spree/api/logger/log"
			else
				@status = [ { "message" => "API-Key isn't valuable"}]
				render "spree/api/logger/log"
			end
		end
	end
end
