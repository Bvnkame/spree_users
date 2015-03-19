module Spree
	HomeController.class_eval do
    respond_to :json
		def ingredients
			@ingredients = Ingredient.all
      @products = Product.all
			respond_with(@ingredients)
      # respond_to do |format|
      #  format.json { render :json => @ingredients }
      # end
    end

    def tam
      @ingredients = Ingredient.all
      respond_to do |format|
        format.json { render :json => @ingredients }
      end
    end
	end
end
