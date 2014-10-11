module ApplicationHelper
  def display_array(array,el)
    if array.last == el
      #{el}
    else
      "#{el}, "
     end
  end
end
