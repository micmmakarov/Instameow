module ApplicationHelper
	def batches_json(batches)
		batches.to_json(methods: [:users_count, :followed_back])
	end
end
