class ReadController < ApplicationController
  def read
    if not jwt_required
      return 0
    end

    id = params[:id]

    if id.blank?
      return render json: {'err'=> 'not_found'}, status: 404
    end

    begin
      user = UserText.find(id)
    rescue ActiveRecord::RecordNotFound
      return render json: {'err'=> 'not_found'}, status: 404
    end

    return render json: user

  end
end
