module ReviewsHelper

  def review_avg(reviews)
    (reviews.inject(0){|result,review| result + review.rate }) / reviews.length
  end

  def avg?(reviews)
    if reviews.present?
      tag.span "REVIEW 平均 ★#{review_avg(reviews)}", class: 'label'
    else
      tag.span "NO YET REVIEW", class: 'label'
    end
  end
end
