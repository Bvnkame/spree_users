module Spree
	class LogUserController < ApplicationController
		def login
			@user = Spree.user_class.find_for_database_authentication(:email => params[:email])
			if  @user &&  @user.valid_password?(params[:password])

				sign_in(@user)
				if !@user.spree_api_key.present?
					@user.generate_spree_api_key!
				end
				respond_to do |format|
					format.json { render :json => { "X-Spree-Token " =>  @user.spree_api_key }, :status => 200}
				end
			else
				respond_to do |format|
					format.json { render :json => { "error " =>  "Email or Password is wrong" }, :status => 404}
				end
			end
		end
	end
end
