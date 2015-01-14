class HomeController < ApplicationController
  def index
    client = Instagram.client(:access_token => session[:access_token])
    InstagramUser.client = client
    #InstagramUser.unfollow_not_followers		
    #binding.pry
  end

  def follow_50
    client = Instagram.client(:access_token => session[:access_token])
    InstagramUser.client = client
  end
end