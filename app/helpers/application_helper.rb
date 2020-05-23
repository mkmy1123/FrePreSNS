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

  def position(expression)
    if expression.is_argument == true
      tag.span "肯定 / POSITIVE", class:'label positive'
    elsif expression.is_argument == false
      tag.span "否定 / NEGATIVE", class:'label negative'
    else
      tag.span "中立 / NEUTRAL", class:'label neutral'
    end
  end
end
