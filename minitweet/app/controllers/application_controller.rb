class ApplicationController < ActionController::Base
  def jwt_required
    header = request.headers['Authorization'][7..]
    payload = TokenManager.access_token_process(header)
    if payload['err']
      render json: {'err': payload['err']}, status: payload['status']
      return false
    else
      return payload
    end
  end

  def jwt_refresh_required
    header = request.headers['Authorization'][7..]
    payload = TokenManager.refresh_token_process(header)
    if payload['err']
      render json: {'err': payload['err']}, status: payload['status']
      return false
    else
      return payload
    end
  end
end
