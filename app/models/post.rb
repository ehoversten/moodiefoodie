class Post < ApplicationRecord

  belongs_to :user
  # GeoKit
  acts_as_mappable :auto_geocode=>{:field=>:address, :error_message=>'Could not geocode address'}
  # acts_as_mappable
  # before_validation :geocode_address, on: :create :update
  # before_validation_on_update :geocode_address
  # after_validation :geocode_address, :if => :address_changed?

  # Geocoder
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?

  has_attached_file :image, styles: { large:"500x500", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
