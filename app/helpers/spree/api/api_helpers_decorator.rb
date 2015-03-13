module Spree
  module Api
    module ApiHelpers
      def user_attributes
        [:id, :email, :created_at, :updated_at, :first_name, :last_name, :birthday]
      end
    end
  end
end
