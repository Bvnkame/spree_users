module Mailer
	class UserMailer < ActionMailer::Base
		default from: "food-service-store.thuyen@sendgrid.com"

		def reset_password_mail(user)
			@user = user
			@url = "http://food-service-store.herokuapp.com/reset_password?id=#{user.id}&token=#{user.reset_password_token}"
			mail(to: user.email, subject: 'Reset Password',
				template_path: 'user_mailer',
				template_name: 'reset_password_email')
		end
	end
end
