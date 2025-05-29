require 'active_record'

class UserSession < ActiveRecord::Base
  validates :user, presence: true
  validates :password, presence: true
end
