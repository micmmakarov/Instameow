require "instagram"

class SessionsController < ApplicationController

  def connect
    redirect_to Instagram.authorize_url(:redirect_uri => CALLBACK_URL, :scope => 'comments relationships likes')
  end

  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token
    client = Instagram.client(:access_token => session[:access_token])
    instagram_user = client.user
    user = User.find_by instagram_id: instagram_user["id"]
    if user.present?
    	sign_in(user)
    else
    	user = User.new
    	user.instagram_id = instagram_user["id"]
    	user.email = "#{instagram_user["id"]}@instameow.com"
    	user.password = Devise.friendly_token.first(8)
    	user.save!
    	sign_in(user)
    end
    redirect_to :controller => 'batches', :action => 'index'
  end
end