class StoreController < ApplicationController
  include CurrentStore

  def index
    @products = Product.order(:title)
    @counter = store_access_count
  end
end
