class User < ApplicationRecord
  has_secure_password
  has_one :profile
  has_many :runs, foreign_key: :runner_id
  has_many :runs_as_companion, foreign_key: :companion_id, class_name: 'Run'

  validates :name, :zipcode, presence: true
  validate :has_valid_zipcode
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, uniqueness: true, presence: true
  validates :password, length: { minimum: 8, maximum: 20 }
  validates :password_confirmation, presence: true
  geocoded_by :zipcode
  before_validation :geocode

  def has_valid_zipcode
    if self.zipcode.to_region == nil
      errors.add(:zipcode, "not a valid zipcode, try 12345 or 12345-1234")
    end
  end
end
