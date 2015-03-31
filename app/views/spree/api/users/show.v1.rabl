object @user

attributes :email, :first_name, :last_name, :avatar_url, :spree_api_key
node(:money_account) { "0" }
node(:currency) { "USD" }
node(:cart_number) { @order.number }