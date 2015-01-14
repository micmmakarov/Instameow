class InstagramUser < ActiveRecord::Base
	class_attribute :client


	belongs_to :batch
	belongs_to :user

	def get_followers
		self.get_followers_for(instagram_id)
	end

	def self.get_followers_for(instagram_id)
	    next_cursor = nil
	    all_followers = []
	    begin 
	    	followers = self.get_page_of_followers(instagram_id, next_cursor)
	    	all_followers << followers
	    	next_cursor = followers.pagination["next_cursor"]
	    end while next_cursor
	    all_followers.flatten!
	end
	def self.get_follows_for(instagram_id)
	    next_cursor = nil
	    all_follows = []
	    begin 
	    	follows = self.get_page_of_follows(instagram_id, next_cursor)
	    	all_follows << follows
	    	next_cursor = follows.pagination["next_cursor"]
	    end while next_cursor
	    all_follows.flatten!
	end

    def self.get_page_of_followers(instagram_id, cursor = nil)
      self.client.user_followed_by(instagram_id, {count: 100, cursor:cursor})
    end
    def self.get_page_of_follows(instagram_id, cursor = nil)
      self.client.user_follows(instagram_id, {count: 100, cursor:cursor})
    end
    



	def self.follow_random(amount)
		users = where(followed: nil).limit(amount)
		follow_users(users)
	end	

	def follow_users(users)
		users.each_with_index do |u, i|
			puts "Following user #{i}"
			error = 0
			begin
				self.client.follow_user(u.instagram_id)
			rescue
				u.error = "not_followed"
				error = 1
			end			
			u.batch = self
			u.followed = DateTime.now unless error == 1
			u.save!
		end
	end

	def follow!
		puts "Following user #{name}"
		error = 0
		begin
			self.client.follow_user(instagram_id)
		rescue
			error = "not_followed"
			error = 1
		end			
		followed = DateTime.now unless error == 1
		save!
	end


	def self.unfollow_batch(batch)
		unfollow_not_followers_for_batch(batch)
	end

	def self.follow_any_users(users)
		users.each do |u|
	
			begin
				self.client.follow_user(u.instagram_id)
			rescue
				error = 1
			end			

			u.followed = DateTime.now
			u.save!
		end
	end

	def self.who_follows_back
	  users = self.client.user_followed_by(count: 5000)
	  follows_back = []
	  InstagramUser.where.not(followed_back:true).all.each do |u|
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

	def self.unfollow_not_followers(amount)		
		InstagramUser.where.not(followed_back:true, followed:nil).where(unfollowed:nil).order(:followed).limit(amount).all.each do |u|
			u.unfollow!
		end	
	end

	def unfollow!
			error = 0
			begin
				r = self.client.unfollow_user(self.instagram_id)
				self.error = nil
			rescue
				puts "something fucked"
				self.error = "not_unfollowed"
				error = 1
			end			
			self.unfollowed = DateTime.now unless error == 1	
			save!
	end

	def self.create_from_array(user_id, users, parent_id='')
		users.each do |u|
			begin
				i_u = self.new
				i_u.instagram_name = u['username']
				i_u.name = u['full_name']
				i_u.image_url = u['profile_picture']
				i_u.instagram_id = u['id']
				i_u.comment = u['bio']
				i_u.parent_instagram_id = parent_id
				i_u.user_id = user_id
				i_u.save!
			rescue => ex
				puts "ERROR! #{ex.message}"
			end
		end
	end


end
