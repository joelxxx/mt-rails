class Product < ActiveRecord::Base
  include CsvModelMixin
  belongs_to :facility

end
