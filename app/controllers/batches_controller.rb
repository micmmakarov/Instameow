require "instagram"

class BatchesController < ApplicationController
  before_action :authenticate_user!

  def index
    begin
      client = Instagram.client(:access_token => session[:access_token])
      user = client.user
      puts user.username
    rescue => ex
      puts "ERROR! #{ex.message}"
    end
    InstagramUser.client = client
    User.client = client  
    InstagramUser.who_follows_back
    @batches = current_user.batches
  end

  def create
  	amount = params[:amount] || 50
  	current_user.follow_new_batch(amount)
  	render json: {error: 0}
  end

  def show
    render json: InstagramUser.all.to_json
  end	

  def update
  end

  def unfollow_not_followers
  	batch = Batch.find(params[:batch_id])
  	batch.unfollow_not_following
  	render json: {error: 0}
  end

end