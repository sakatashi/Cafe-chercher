class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @keyword = params[:keyword]
    @post = Post.search(@keyword).page(params[:page])
  end
end
