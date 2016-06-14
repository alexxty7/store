module ReviewHelper
  def render_star(value)
    return '' unless (1..5).cover?(value)

    html = ''
    value.times { html << "<span class='glyphicon glyphicon-star'></span>\n" }
    (5 - value).times { html << "<span class='glyphicon glyphicon-star-empty'></span>\n" }

    html.html_safe
  end
end
