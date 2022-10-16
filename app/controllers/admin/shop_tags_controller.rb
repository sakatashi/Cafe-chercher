class Admin::ShopTagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :shop_tag_choice, only: [:edit, :update, :destroy]

  def new
    @shop_tag = ShopTag.new
    @shop_tags = ShopTag.all.order(created_at: "DESC").page(params[:page]).per(20)
  end

  def create
    shop_tag = ShopTag.new(shop_tag_params)
    if shop_tag.save
      redirect_to request.referer, notice: "タグを新規登録しました。"
    else
      redirect_to request.referer, alert: "タグ登録に失敗しました。"
    end
  end

  def edit
    @shop_tags = ShopTag.all.order(created_at: "DESC").page(params[:page]).per(20)
  end

  def update
    if @shop_tag.update(shop_tag_params)
      redirect_to new_admin_shop_tag_path, notice: "設備タグ名を更新しました。"
    else
      redirect_to request.referer, alert: "編集内容をご確認ください。"
    end
  end

  def destroy
    @shop_tag.destroy
    redirect_to request.referer, notice: "設備タグを削除しました。"
  end

  private
    def shop_tag_params
      params.require(:shop_tag).permit(:name)
    end

    def shop_tag_choice
      @shop_tag = ShopTag.find(params[:id])
    end
end