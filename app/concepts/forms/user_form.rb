# frozen_string_literal: true

module Forms
  # Form object for User Model
  class UserForm < Reform::Form
    property :name
    property :email
    property :facebook_id
    property :gmail_id

    validates :name, :email, presence: true
    validates_uniqueness_of :email
  end
end
