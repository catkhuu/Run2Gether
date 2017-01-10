class User < ApplicationRecord
  has_secure_password
  has_one :profile
  has_many :runs, foreign_key: :runner_id
  has_many :runs_as_companion, foreign_key: :companion_id, class_name: 'Run'

  validates :name, :zipcode, :latitude, :longitude, presence: true
  validates_format_of :zipcode, :with => /\A\d{5}-\d{4}|\A\d{5}\z/, :message => "should be in the form 12345 or 12345-1234"
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }, uniqueness: true, presence: true
  validates :password, length: { minimum: 8, maximum: 20 }
  validates :password_confirmation, presence: true
  geocoded_by :zipcode
  after_validation :geocode

  # def narrow_by_experience(run_seeker)
  #   self.profile.experience == run_seeker.profile.experience
  # end
end
