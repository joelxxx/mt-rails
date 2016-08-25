class ApplicationController < ActionController::Base
  before_filter :set_tenant
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_tenant
    logger.info("Subdomain is #{params[:subdomain]}")
    @tenant = params[:subdomain] || 'public'
    logger.info("Setting tenant to #{@tenant}")
    Apartment::Tenant.switch!(@tenant.downcase)
  end

  def url_options
    {:subdomain => @tenant_id}.merge(super)
  end    

end
