class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.new(review_params)
    @review.rate = params[:rate]
    @review.expression_id = params[:review][:expression_id]
    if @review.save
      respond_to do |format|
        format.js { flash.now[:notice] = "REVIEWが保存されました！ご協力ありがとうございます。" }
      end
    else
      respond_to do |format|
        format.js { flash.now[:alert] = "Error!ブラウザの再読み込みをお試しください" }
      end
    end
  end

  def update
    @review = Review.find(params[:id])
    @review.rate = params[:rate]
    if @review.update(review_params)
      respond_to do |format|
        format.js { flash.now[:notice] = "REVIEWが更新されました！ご協力ありがとうございます。" }
      end
    else
      respond_to do |format|
        format.js { flash.now[:alert] = "Error!ブラウザの再読み込みをお試しください" }
      end
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :rate, :expression_id)
  end
end
