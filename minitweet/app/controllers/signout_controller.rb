class SignoutController < ApplicationController
  skip_before_action :verify_authenticity_token

  def signout
    ip = request.remote_ip

    if not jwt_refresh_required
      return 0
    end

    header = request.headers['Authorization'][7..]

    tokenmanager = TokenManager.find_by_refresh_token(header)
    if tokenmanager.blank?
      return render json: {'err'=> 'JWT_invalid'}, status: 400
    end

    if tokenmanager.user_ip != ip
      return render json: {'err'=> 'wrong_approach'}
    end

    tokenmanager.delete
    tokenmanager.save

    return render json: {'status'=> 'success!'}

  end
end
