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
    if expression.style == '中立'
      tag.span "中立 / NEUTRAL", class: 'label neutral'
    elsif expression.style == '肯定的'
      tag.span "肯定 / POSITIVE", class: 'label positive'
    else
      tag.span "否定 / NEGATIVE", class: 'label negative'
    end
  end

  def neutral(expressions)
    expressions.where(style: 0)
  end

  def positive(expressions)
    expressions.where(style: 1)
  end

  def negative(expressions)
    expressions.where(style: 2)
  end
end
