class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, through: :listings

  def city_openings(start_date, end_date)
    results = []
    listings.each do |listing|
      listing.reservations.each do |reservation|
        reservation.checkin.to_s >= start_date && reservation.checkout.to_s <= end_date
      end
    end
  end

  def self.highest_ratio_res_to_listings
    highest_ratio_area = 0
    highest_ratio = 0

    self.all.each do |area|
      current_ratio = (area.reservations.count.to_f / area.listings.count.to_f)
      if current_ratio > highest_ratio
        highest_ratio = current_ratio
        highest_ratio_area = area
      end
    end

    highest_ratio_area
  end

  def self.most_res
    most_res_area = nil
    highest_area_count = 0
    self.all.each do |area|
      if area.reservations.count > highest_area_count
        most_res_area = area
        highest_area_count = area.reservations.count
      end
    end
    most_res_area
  end

end
