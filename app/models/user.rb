# Schema Information
#
#  Table Name: users
#
#  id                :integer
#  username          :string
#  first_name        :string
#  last_name         :string
#  password_digest   :string
#  created_at        :datetime
#  updated_at        :datetime
#

class User < ActiveRecord::Base
  has_many :movies

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 2 }
  validates :password, presence: true, confirmation: true, length: { minimum: 4 }, on: :create

  def self.authenticate(username, password)
    if user = find_by(username: username)
      user.authenticate(password)
    else
      false
    end
  end

  def full_name
    if self.first_name || self.last_name
      @full_name ||= [self.first_name, self.last_name].compact.join(" ")
    else
      @full_name ||= self.username
    end
  end

  def unwatched_movies
    self.movies.where(watched: false)
  end

  def watched_movies
    self.movies.where(watched: true)
  end
end
