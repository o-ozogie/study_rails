class WriteController < ApplicationController
  skip_before_action :verify_authenticity_token


  def write
    @MAX_TITLE_LENGTH = 20
    @MAX_TEXT_LENGTH = 1500

    payload = jwt_required

    if not payload
      return 0
    end

    title = params[:title]
    text = params[:text]

    if title.blank? or text.blank?
      return render json: {'err'=> 'valueless'}, status: 401
    end

    if title.length > @MAX_TITLE_LENGTH
      return render json: {'err'=> 'Exceed_title_length'}, status: 413
    end

    if text.length > @MAX_TEXT_LENGTH
      return render json: {'err'=> 'Exceed_text_length'}, status: 413
    end

    @usertext = UserText.new

    @usertext.user_id = payload['user_id']
    @usertext.title = title
    @usertext.text = text
    @usertext.save

    return render json: {'status'=> 'success!'}

  end
end
