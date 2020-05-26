class HomeController < ApplicationController
  def top
    rank_argument_id = Expression.group(:argument_id).order('count_argument_id DESC').limit(3).count(:argument_id).keys
    @rank_argument = Argument.find(rank_argument_id)
    @argument = @rank_argument.first
    @random_user = User.offset( rand(User.count) ).first
    @random_exp = Expression.offset( rand(Expression.count) ).first
    review_exp_id = Review.group(:expression_id).order('count_expression_id DESC').limit(1).count(:expression_id).keys
    review_exp = Expression.find(review_exp_id)
    @top_review = review_exp.first
    check_arg_id = Check.group(:argument_id).order('count_argument_id DESC').limit(3).count(:argument_id).keys
    @top_check = Argument.find(check_arg_id)
  end

  def about
  end

  def howto
  end

  def word
  end
end
