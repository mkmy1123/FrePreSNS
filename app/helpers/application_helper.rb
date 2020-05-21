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
end
