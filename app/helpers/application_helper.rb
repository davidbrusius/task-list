module ApplicationHelper
  def bootstrap_class_for(flash_type)
    bootstrap_alert_classes = {
      success:  "alert-success",
      error:    "alert-danger",
      alert:    "alert-warning",
      notice:   "alert-info"
    }
    bootstrap_alert_classes[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type.to_sym)}") do
        concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def active_link_to(name = nil, path = nil, html_options = {})
    html_options[:class] = "#{html_options[:class]} active" if current_page?(path)
    link_to(name, path, html_options)
  end
end
