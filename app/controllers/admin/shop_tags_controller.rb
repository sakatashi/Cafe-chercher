class Admin::ShopTagsController < ApplicationController
  def new
    @shop_tag = ShopTag.new
    @shop_tags = ShopTag.all.order(created_at: "DESC")
  end

  def create
    shop_tag = ShopTag.new(shop_tag_params)
    if shop_tag.save
      redirect_to request.referer, notice: "タグを新規登録しました。"
    else
      redirect_to request.referer, alert: "タグ登録に失敗しました。"
    end
  end

  def shop_tag_params
    params.require(:shop_tag).permit(:name)
  end
end

