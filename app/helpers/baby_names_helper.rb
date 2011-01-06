module BabyNamesHelper
  def example_span_for(url)
    content_tag(:ul, content_tag(:li, content_tag(:span, "example: #{link_to(url, url)}")))
  end

  def example_for(field, value)
    content_tag(:li, field + example_span_for(root_url(field => value)))
  end
end
