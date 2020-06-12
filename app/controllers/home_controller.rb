class HomeController < ApplicationController
  before_action :ranking_arg, only: [:top]
  before_action :random_user, only: [:top]
  before_action :random_exp, only: [:top]
  before_action :review_rank, only: [:top]
  before_action :check_rank, only: [:top]
  require 'net/http'

  def top
    # newsAPIを使用
    # 今回はエラー対応していないが理解が追いついたらすべき
    uri = URI.parse('https://newsapi.org/v2/top-headlines?country=jp&apiKey=' + ENV['NEWS_API_KEY'])
    json = Net::HTTP.get(uri)
    moments = JSON.parse(json)
    @moments = moments['articles']
  end

  def about
  end

  def howto
  end

  def word
  end

  def guest
    user = User.friendly.find('testtester')
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  private

  def ranking_arg
    # EXPRESSION側から集計、上位三件を取得
    rank_argument_id = Expression.group(:argument_id).order('count_argument_id DESC').limit(3).count(:argument_id).keys
    @rank_argument = Argument.find(rank_argument_id)
    @argument = @rank_argument.first
  end

  def random_user
    # 実際数を確認してからランダムな数値を取得、そこからの範囲の最初を得る
    @random_user = User.offset(rand(User.count)).first
  end

  def random_exp
    @random_exp = Expression.offset(rand(Expression.count)).first
  end

  def review_rank
    review_exp_id = Review.group(:expression_id).order('count_expression_id DESC').limit(1).count(:expression_id).keys
    review_exp = Expression.find(review_exp_id)
    @top_review = review_exp.first
  end

  def check_rank
    check_arg_id = Check.group(:argument_id).order('count_argument_id DESC').limit(3).count(:argument_id).keys
    @top_check = Argument.find(check_arg_id)
  end
end
