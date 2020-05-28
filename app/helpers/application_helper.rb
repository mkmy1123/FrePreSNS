module ApplicationHelper
  def full_title(page_title)
    base_title = "表現の自由を守る<<FrePreSNS>>"
    if page_title.empty?
      base_title
    else
      " ~ " + page_title + " ~ " + base_title
    end
  end

  def find_argument(argument_id)
    Argument.find(argument_id)
  end

  def find_arg_topic(argument_id)
    Argument.find(argument_id).topic
  end

  def get_expressions(argument)
    Expression.where(argument_id: argument)
  end

  def position(expression)
    if expression.position_of == '中立'
      tag.span "中立 / NEUTRAL", class: 'label neutral'
    elsif expression.position_of == '肯定的'
      tag.span "肯定 / POSITIVE", class: 'label positive'
    else
      tag.span "否定 / NEGATIVE", class: 'label negative'
    end
  end

  def neutral_count(expressions)
    expressions.where(position_of: 0).length
  end

  def positive_count(expressions)
    expressions.where(position_of: 1).length
  end

  def negative_count(expressions)
    expressions.where(position_of: 2).length
  end
end
