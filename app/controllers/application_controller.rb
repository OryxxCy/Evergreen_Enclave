class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :cart

  private
  def initialize_session
    session[:shopping_cart] ||= {}
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end
