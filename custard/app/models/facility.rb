
class Facility < ActiveRecord::Base
  include CsvModelMixin
  has_many :product
end
