module CheckoutHelper
  def checkout_progress
    content_tag(:ul, class: 'progress-steps nav nav-pills nav-justified') do
      wizard_steps.collect do |every_step|
        class_str = 'unfinished'
        class_str = 'active' if every_step == step
        class_str = 'completed' if past_step?(every_step)
        concat(
          content_tag(:li, class: class_str) do
            link_to_next_step(every_step)
          end
        )
      end
    end
  end

  private

  def link_to_next_step(step)
    if past_step?(step)
      link_to(t(step), wizard_path(step))
    else
      content_tag('a', t("wicked.#{step}"))
    end
  end
end
