class ReviewsController < ApplicationController
  def create
    review = Review.new(review_params)
    review.rate = params[:score]
    review.expression_id = params[:review][:expression_id]
    if review.save
      redirect_to review.expression,notice: "REVIEWが保存されました！ご協力ありがとうございます。"
    else
      redirect_to review.expression,alert: "トラブルが起きました、もう一度REVIEWを投稿してください..."
    end
  end

  def update
    review = Review.find(params[:id])
    review.rate = params[:score]
    if review.update(review_params)
      redirect_to review.expression,notice: "REVIEWが更新されました！ご協力ありがとうございます。"
    end
  end

  private
    def review_params
      params.require(:review).permit(:user_id, :rate, :expression_id)
    end
end
