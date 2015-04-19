object @user

attributes :id, :email, :first_name, :last_name, :avatar_url, :spree_api_key
node(:money_account) { |p| 
		if p.user_account 
			p.user_account.account
		else
			"0"
		end }
node(:currency) { |p| 
		if p.user_account 
			p.user_account.currency
		else
			"VND"
		end }
node(:cart_number) { @order.number }