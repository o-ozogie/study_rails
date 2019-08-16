class TokenManager < ApplicationRecord

  @SECRET_KEY = 'variable'
  @ISS = 'notice_board/signin'
  @ALGORITHM = 'HS256'
  @MINIMAL_JWT_LENGTH = 100

  def self.create_access_token(user_id)
    type = 'access_token'
    payload = {
        'exp'=> exp(type),
        'iss'=> @ISS,
        'type'=> type,
        'user_id'=> user_id
    }
    return JWT.encode(payload, @SECRET_KEY, @ALGORITHM)
  end

  def self.create_refresh_token(user_id, ip)
    type = 'refresh_token'
    payload = {
        'exp'=> exp(type),
        'iss'=> @ISS,
        'type'=> type,
        'user_id'=> user_id
    }
    refresh_token = JWT.encode(payload, @SECRET_KEY, @ALGORITHM)

    @token_manager = TokenManager.new
    @token_manager.user_id = user_id
    @token_manager.refresh_token = refresh_token
    @token_manager.user_ip = ip
    @token_manager.save

    return refresh_token

  end

  def self.access_token_process(token)
    if token.blank?
      return {'err'=> 'JWT_required', 'status'=> 401}
    end

    begin
      decoded_token = JWT.decode(token, @SECRET_KEY, @ALGORITHM)
    rescue JWT::ExpiredSignature
      return {'err'=> 'JWT_expired', 'status'=> 408}
    rescue
      return {'err'=> 'JWT_invalid', 'status'=> 400}
    end

    if decoded_token[0]['type'] != 'access_token'
      return {'err'=> 'access_token_required', 'status'=> 401}
    end

    return decoded_token[0]

  end

  def self.refresh_token_process(token)
    if token.blank?
      return {'err'=> 'JWT_required', 'status'=> 401}
    elsif token.length <= @MINIMAL_JWT_LENGTH
      return {'err'=> 'JWT_invalid', 'status'=> 400}
    end

    begin
      decoded_token = JWT.decode(token, @SECRET_KEY, @ALGORITHM)
    rescue JWT::ExpiredSignature
      return {'err'=> 'JWT_expired', 'status'=> 408}
    rescue
      return {'err'=> 'JWT_invalid', 'status'=> 400}
    end

    if decoded_token[0]['type'] != 'refresh_token'
      return {'err'=> 'refresh_token_required', 'status'=> 401}
    end

    return decoded_token[0]

  end

  private

  def self.exp(type)
    if type == 'access_token'
      return (Time.now + 15.minutes).to_i
    elsif type == 'refresh_token'
      return (Time.now + 2.weeks).to_i
    end

  end
end
