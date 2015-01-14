require "instagram"

class MineController < ApplicationController
  before_action :authenticate_user!
  class_attribute :client

  def index
    client = Instagram.client(:access_token => session[:access_token])
    InstagramUser.client = client
    User.client = client
    @followers = current_user.get_follows
  end

  def create
    client = Instagram.client(:access_token => session[:access_token])
    InstagramUser.client = client
    followers = []
    params[:ids].each do |instagram_id|
      InstagramUser.create_from_array(
        current_user.id, InstagramUser.get_followers_for(instagram_id), instagram_id
      )
    end
    render json: {error: 0}
  end
    
end