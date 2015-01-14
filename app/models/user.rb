class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :batches
  has_many :instagram_users
  class_attribute :client

  	def follow_new_batch(amount)
		users = instagram_users.where(followed: nil).limit(amount)
		batch = batches.create!
		batch.follow_users(users)
	end

	def get_followers
		InstagramUser.client = self.client unless InstagramUser.client.present?
		InstagramUser.get_followers_for(instagram_id)
	end

	def get_follows
		InstagramUser.client = self.client unless InstagramUser.client.present?
		InstagramUser.get_follows_for(instagram_id)
	end


	def user_mine
	end

end
