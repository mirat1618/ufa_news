class PostsController < ApplicationController
  def index
    @test = 'Hello'
    @traffic_posts = Post.where(category: 'traffic')
    @sport_posts = Post.where(category: 'sport')
    @gov_posts = Post.where(category: 'gov')
  end
end
