class Tenant < ActiveRecord::Base
  before_create   :apartment_tenant_create

  def self.tenant_names
    tnames = []
    Tenant.select("name").each do |tenant|
      tnames << tenant.name
    end
    return tnames
  end

  def apartment_tenant_create()
    Apartment::Tenant.create(self.name)
  end

  private
    def tenant_params
      params.require(:name, :description)
    end
end
