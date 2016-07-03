module ReviewHelper
  def render_star(value)
    return '' unless (1..5).cover?(value)

    html = ''
    value.times do
      html << "<span class='glyphicon glyphicon-star'></span>\n"
    end

    (5 - value).times do
      html << "<span class='glyphicon glyphicon-star-empty'></span>\n"
    end

    html.html_safe
  end
end
