class Post < ApplicationRecord

  belongs_to :user
  # GeoKit
  # acts_as_mappable :auto_geocode=>{:field=>:address, :error_message=>'Could not geocode address'}
  # after_save :geocode_address, on: :update
  acts_as_mappable
  before_validation :geocode_address, on: [:create, :update]

  # before_validation_on_update :geocode_address
  # after_validation :geocode_address, :if => :address_changed?

  def geocode_address
    geo=Geokit::Geocoders::GoogleGeocoder.geocode(address)
    errors.add(:address, "Could not Geocode address") if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end

  # Geocoder
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  has_attached_file :image, styles: { large:"500x500", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
