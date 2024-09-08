# app/services/authentication_service.rb
class AuthenticationService
  class << self
    def encode(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      JWT.decode(token, Rails.application.secrets.secret_key_base).first
    rescue JWT::DecodeError
      nil
    end
  end
end
