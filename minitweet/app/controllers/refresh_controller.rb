class RefreshController < ApplicationController
  def refresh
    header = request.headers['Authorization'][7..]
    ip = request.remote_ip
    payload = jwt_refresh_required

    if not payload
      return 0
    end

    begin
      tokenmanager = TokenManager.find_by_refresh_token(header)
    rescue JWT::ExpiredSignature
      return render json: {'err'=> 'JWT_expired'}, status: 408
    rescue
      return render json: {'err'=> 'JWT_invalid'}, status: 400
    end

    if tokenmanager.blank?
      return render json: {'err'=> 'JWT_invalid'}
    end

    if tokenmanager.user_ip != ip
      return render json: {'err'=> 'wrong_approach'}
    end

    return render json: {'access_token'=> TokenManager.create_access_token(payload['user_id'])}

  end
end
