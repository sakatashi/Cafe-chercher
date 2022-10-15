class Public::SearchesController < ApplicationController
  def search
    @keyword = params[:keyword]
    @post = Post.search(@keyword).page(params[:page])
  end
end
