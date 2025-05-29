require 'securerandom'
require_relative '../models/user_session'

class AuthService
  def initialize
  end

  def authenticate(user, password)
    @user_session = UserSession.find_by(user: user)
    if @user_session.password == password
      @user_session.token = SecureRandom.hex(16)
      @user_session.save
      @user_session.token
    end
  end

  def valid?(token)
    UserSession.find_by(token: token).present?
  end
end
