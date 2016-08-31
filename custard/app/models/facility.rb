
class Facility < ActiveRecord::Base

  def self.importCSV(file)
    CSV.foreach(file.path, headers: true) do |row|
      obj = find_by_id(row["id"]) || new
      obj.attributes = row.to_hash.slice(*row.to_hash.keys)
      obj.save!
    end
  end

  def self.exportCSV(options={})
    CSV.generate(options) do |csv|
      csv << column_names
      self.all.each do |row|
        csv << row.attributes.values_at(*column_names)
      end
    end
  end

  has_many :product

end
