class EpicenterController < ApplicationController

  before_action :authenticate_user!, except: [:feed]

  def feed
    @tweet = Tweet.new

    if user_signed_in?
	  @following_tweets = []

	  Tweet.all.each do |tweet|
	    if current_user.following.include?(tweet.user_id) || current_user.id == tweet.user_id
	      @following_tweets.push(tweet)
	    end
	  end
    else
      redirect_to tweets_path
    end
	end

  def show_user
  	@user = User.find(params[:id])
    @tweet = Tweet.new
  end

  def now_following
    # We are adding the user.id of the user you want to 
    # follow to your following array.
    # and we want to make sure it's saved in there as an integer
    current_user.following.push(params[:id].to_i)
    current_user.save

    redirect_to show_user_path(id: params[:id])
  end

  def unfollow
    current_user.following.delete(params[:id].to_i)
    current_user.save

    redirect_to show_user_path(id: params[:id])   
  end

  def tag_tweets
    @tag = Tag.find(params[:id])
  end

  def all_users
    @users = User.all
    # or:
    # User.order(:username)
    # User.order(:name)
    # or whatever order you'd
    # like to put them in
  end

    def following
    @user = User.find(params[:id])
    @users = []

    User.all.each do |user|
      if @user.following.include?(user.id)
        @users.push(user)
      end
    end
  end

  def followers
    @user =  User.find(params[:id])
    @users = []

    User.all.each do |user|
      if user.following.include?(@user.id)
        @users.push(user)
      end
    end
  end

  
end
