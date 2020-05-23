module ApplicationHelper
  def full_title(page_title)
    base_title = "表現の自由を守る<<FrePreSNS>>"
    if page_title.empty?
      base_title
    else
      page_title + " ~ " + base_title
    end
  end

  def find_argument(argument_id)
    Argument.find(argument_id)
  end

  def get_expressions(argument)
    Expression.where(argument_id: argument)
  end

  def position(expression)
    if expression.is_argument == true
      tag.span "肯定 / POSITIVE", class:'label positive'
    elsif expression.is_argument == false
      tag.span "否定 / NEGATIVE", class:'label negative'
    else
      tag.span "中立 / NEUTRAL", class:'label neutral'
    end
  end
  
  def positive(expressions)
    expressions.where(is_argument: true)
  end

  def negative(expressions)
    expressions.where(is_argument: false)
  end

  def neutral(expressions)
    expressions.where(is_argument: nil)
  end
end
