class Public::SearchesController < ApplicationController
  def search
    @keyword = params[:keyword]
    @post = Post.search(@keyword)
   
  end
end
