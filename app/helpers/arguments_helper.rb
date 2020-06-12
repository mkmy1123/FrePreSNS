module ArgumentsHelper
  def find_argument(argument_id)
    Argument.find(argument_id)
  end

  def find_arg_topic(argument_id)
    Argument.find(argument_id).topic
  end
end
