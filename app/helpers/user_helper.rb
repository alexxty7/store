module UserHelper
  def error_messages_for(target, attr = 'all')
    errors = find_errors_for(target, attr)
    return '' if errors.empty?

    messages = errors.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-danger"> <button type="button"
    class="close" data-dismiss="alert">x</button>
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  private

  def find_errors_for(target, attr)
    return target.errors.full_messages if attr == 'all'
    target.errors.full_messages.select { |msg| msg =~ /#{attr}/i }
  end
end
