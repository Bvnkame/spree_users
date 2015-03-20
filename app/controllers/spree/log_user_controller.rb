module Spree
	class LogUserController < ApplicationController
		def login
			@user = Spree.user_class.find_for_database_authentication(:email => params[:email])
			if  @user &&  @user.valid_password?(params[:password])

				sign_in(@user)
				p spree_current_user
				if !@user.spree_api_key.present?
					@user.generate_spree_api_key!
				end
					render "spree/api/users/show"
			else
				respond_to do |format|
					format.json { render :json => { "error " =>  "Email or Password is wrong" }, :status => 404}
				end
			end
		end

		def logout
			p spree_current_user
			sign_out(spree_current_user)  if spree_current_user
			p spree_current_user
			respond_to do |format|
				format.json { render :json => { "message " =>  "Logout Successful" }, :status => 200}
			end
		end
	end
end
