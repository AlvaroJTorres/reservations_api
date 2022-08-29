# frozen_string_literal: true

module Forms
  # Form object for Restaurant Model
  class RestaurantForm < Reform::Form
    property :name
    property :address
    property :user_id
    property :images

    validates :name, :address, presence: true
    validates_uniqueness_of :name
  end
end
