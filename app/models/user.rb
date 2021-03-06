class User < ActiveRecord::Base
  has_many :listings, :foreign_key => 'host_id'
  has_many :reservations, :through => :listings
  has_many :trips, :foreign_key => 'guest_id', :class_name => "Reservation"
  has_many :reviews, :foreign_key => 'guest_id'

  ## As A Host ##
  # as a host, knows about the guests its had
  has_many :guests, through: :reservations, class_name: "User"
  # as a host, knows about its reviews from guests
  has_many :host_reviews, :through => :guests, source: :reviews

  ## As A Guest ##
  has_many :trip_listings, :through => :trips, source: :listing
  # as a guest, knows about the hosts its had
  has_many :hosts, through: :trip_listings, class_name: "User"

end
