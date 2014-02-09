class HomeController < ApplicationController
  def index
    @posts = Post.order(updated_at: :desc)
    n = @posts.count
    @top_post = @posts.first
    if n >= 2
      @recent_posts = @posts.offset(1).limit(5)
      @is_more_posts = n > 6
    end

    if @current_season.present?
      @top_scores = Hash[Machine.all.map {|machine|
        [machine, machine.get_top_scores(@current_season)]
      }]
    end
  end
end
