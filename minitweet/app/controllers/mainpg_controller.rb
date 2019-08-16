class MainpgController < ApplicationController
  def mainpg
    if not jwt_required
      return 0
    end

    page = (params[:page].to_i * 8) + 1
    page_end = page + 7
    text_list = []
    (page..page_end).each do |i|
      begin
        text = UserText.find(i)
      rescue ActiveRecord::RecordNotFound
        break
      end
 
      temp = {}

      temp['id'] = text['id']
      temp['user_id'] = text['user_id']
      temp['title'] = text['title']
      temp['created_at'] = text['created_at']
      text_list << temp
    end

    return render json: text_list

  end
end