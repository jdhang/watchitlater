# Schema Information
#
# Table Name: movies
#
# id                      :integer
# user_id                 :integer
# title                   :string
# watched                 :boolean (default: false)
# created_at              :datetime
# updated_at              :datetime
#

class Movie < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
