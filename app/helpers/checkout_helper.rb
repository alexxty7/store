module CheckoutHelper
  def checkout_progress
    states = wizard_steps
    items = states.map do |state|
      text = state.to_s.titleize

      css_classes = []
      current_index = states.index(step)
      state_index = states.index(state)

      if state_index < current_index
        css_classes << 'completed'
        text = link_to text, wizard_path(state)
      end

      css_classes << 'active' if state == step

      if state_index < current_index
        content_tag('li', text, class: css_classes.join(' '))
      else
        content_tag('li', content_tag('a', text), class: css_classes.join(' '))
      end
    end
    content_tag('ul', raw(items.join("\n")), class: 'progress-steps nav nav-pills nav-justified')
  end
end
