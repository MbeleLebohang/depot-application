module CurrentStore
  extend ActiveSupport::Concern

  private
  def store_access_count
    if session[:counter].nil?
      session[:counter] = 0
    else
      session[:counter] += 1
    end
  end

  # def reset_store_access_count
  #   session[:counter] = 0
  # end
end