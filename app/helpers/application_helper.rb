module ApplicationHelper
  def show_error_messages_if_any messages
    return "" if !messages or !messages.any?

    messages = messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div class="alert alert-danger" role="alert">
      <button class="pull-right closable">x</button>
      <strong> Something went wrong:</strong>
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
