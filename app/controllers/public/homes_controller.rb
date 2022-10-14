class Public::HomesController < ApplicationController
  def top
    @new_posts = Post.all.order("created_at DESC").first(4)
  end

  def about
  end
end
