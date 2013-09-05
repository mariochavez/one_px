module ApplicationHelper
  def display_form_error_message(model)
    content_tag :div, class: 'notice' do
      'Upps we have an error'
    end if model.errors.any?
  end

  def display_field_error_message(model, field)
    content_tag :span, class: 'error' do
      model.errors[field].first
    end if model.errors[field].any?
  end
end
