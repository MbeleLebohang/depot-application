module CurrentCart
  extend ActiveSupport::concerns

  private
    def set_cart
      # Get the cart of this session
      @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      # If the session has no cart, create one, assign this sesion cart_id to this new cart and return the new cart
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
end