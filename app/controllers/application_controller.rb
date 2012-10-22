class ApplicationController < ActionController::Base
  protect_from_forgery

  # Forces user to authenticate with Instagram OAuth before allowing access to interface elements.
  def require_authentication
    unless session[:authenticated]
      if Rails.env.production?
        redirect_to "#{view_context.base_url}/auth/instagram"
      else
        redirect_to "#{view_context.base_url}/auth/developer"
      end
    end
  end
end
