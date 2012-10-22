class SessionsController < ApplicationController
	# This controller manages authentication, and therefore, accessing this section does not require authentication.
  skip_before_filter :require_authentication

  # Create an authorized session if the e-mail received from Google Authentication callback is a a MobME email address.
  def create
    unless param[:error]
      session[:authenticated] = auth_hash
      logger.info { auth_hash }
      redirect_to root_url
    else
      redirect_to root_url, :error => param[:error_description]
    end
  end

  # Authentication failure management.
  def failure
    require 'base64'
    logger.info { param }
    session[:authenticated] = false
    case params[:message]
      when "invalid_credentials"
        @reason = :invalid_credentials
      else
        @reason = params.inspect
    end

    redirect_to root_url, :error => param[:error_description]
  end

  # Logout.
  def destroy
    session[:authenticated] = false
    redirect_to root_url, :notice => "You have successfully logged out"
  end

  protected

  # Returns omniauth's post-authorization details hash.
  def auth_hash
    request.env['omniauth.auth']
  end
end
