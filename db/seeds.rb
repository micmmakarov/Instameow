
data = <<EOF
EOF

#data.gsub! '`', ''
#data.gsub! 'null', "\"\""

users = JSON.parse data
users.each do |u|
	user = InstagramUser.new
	unless u["comment"] == "no-good"
		user.comment = u["comment"]
	  	user.created_at = u["created_at"]
	    user.followed = true #u["followed"]
	    user.unfollowed = u["unfollowed"]
	    user.followed_back = u["followed_back"]
	    user.image_url = u["image_url"]
	    user.instagram_id = u["instagram_id"]
	    user.batch_id = u["batch_id"]
	    user.save!
    end
end