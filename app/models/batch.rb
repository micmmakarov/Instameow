class Batch < ActiveRecord::Base
	has_many :instagram_users
	belongs_to :user
	class_attribute :client
	

	def users_count
		instagram_users.count
	end

	def followed_back
		instagram_users.where(followed_back: true).count
	end

	def unfollow_not_following
		self.who_follows_back
		instagram_users.where.not(followed_back: true).each do |u|
			u.unfollow!
		end
		self.unfollowed_not_followers = DateTime.now
		self.save!
	end
	
	def follow_users(users)
		users.each_with_index do |u, i|
			u.follow!
			u.batch = self
			u.save!
		end
	end

	def who_follows_back
	  users = InstagramUser.client.user_followed_by(count: 5000)
	  follows_back = []
	  instagram_users.where.not(followed_back:true).all.each do |u|
	  	users.each do |uu|
	  		if u.instagram_id == uu['id']
	  			follows_back << u
  			end  
  	  	end
  	  end
  	  follows_back.each do |u|
  	  	u.followed_back = true
  	  	u.save!
  	  end

	end

end
