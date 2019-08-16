class SigninController < ApplicationController

  def signin
    @userinfo = UserInfo.new
    id = params[:user_id]
    pw = params[:password]
    ip = request.remote_ip

    users = UserInfo.find_by(user_id: id)
    if users == nil
      return render json: {'err'=> 'valueless'}, status: 401
    elsif users['password'] == pw
      return render json: {
          'access_token'=> TokenManager.create_access_token(id),
          'refresh_token'=> TokenManager.create_refresh_token(id, ip)
      }
    else
      return render json: {'err'=> 'valueless'}, status: 401
    end

  end
end
