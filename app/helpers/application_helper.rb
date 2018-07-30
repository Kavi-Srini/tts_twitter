module ApplicationHelper

	def get_followers(user_id)
		user = User.find(user_id)
		followers = []

		User.all.each do |follower|
			if follower.following.include?(user.id)
				followers.push(follower)
			end
		end
			return followers.count
	end


	def top_number_tweets(user_id)
    tweets = Tweet.all
    if tweets.length > 0

    tweets = Tweet.where(user_id: user_id)
    return tweets.length
   end 
	end 

	def hot_tags
		tweets = TweetTag.all

		if tweets.length >0
			tag_arr = []
			tag_ids = []
			count = 0

			tags = TweetTag.all.group_by { |h| h['tag_id']}.to_a.sort_by{|x| x[1].length}

          count = 1

          if tags.length < 3
            (tags.length).times do
              tag_ids.push(tags[tags.length-count][0])
              count +=1
            end  
          else   
            3.times do 
              tag_ids.push(tags[tags.length-count][0])
              count +=1
            end
          end 
        end 

       tag_ids.each do |phrase|
        tag_phrase = Tag.find(phrase)
        tag_arr.push(tag_phrase)
       end  

      return tag_arr
		end


	end

	def top_tweeter
		tweets = Tweet.all
		if tweets.length > 0
			user_id = Tweet.all.group_by {|h| h['user_id']}.to_a.max_by {|x| x[1].length}.first
			user = User.find (user_id)
			return user
	end

 

end
