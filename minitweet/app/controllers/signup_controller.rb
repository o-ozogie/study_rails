class SignupController < ApplicationController
  skip_before_action :verify_authenticity_token

  def signup
    id = params[:user_id]
    pw = params[:password]
    name = params[:user_name]
    if id.blank? or pw.blank? or name.blank?
      return render json: {'err'=> 'valueless'}, status: 401
    end

    users = UserInfo.find_by(user_id: id)
    if users != nil
      return render json: {'err'=> 'ID_duplicated'}, status: 409
    end

      @userinfo = UserInfo.new

      @userinfo.user_id = id
      @userinfo.password = pw
      @userinfo.user_name = name
      @userinfo.save

      return render json: {'status'=> 'success!'}

  end

end