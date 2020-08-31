class PostsController < ApplicationController
  def index
    @traffic_posts = Post.traffic
    @sport_posts = Post.sport
    @gov_posts = Post.gov
  end
end
