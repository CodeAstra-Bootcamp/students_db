module ApplicationHelper
  def flash_messages_tag
    content = ""
    flash.each do |msg_type, msg|
      # Devise sets the flash keys to "notice" and "alert",
      # while the corresponding bootstrap counterparts are "success" and "danger"
      msg_type = "success" if msg_type == "notice"
      msg_type = "danger" if msg_type == "alert"
      content += content_tag(:div, class: "alert alert-#{msg_type} alert-dismissible", role: "alert") do
        content_tag(:button, class: "close", data: {dismiss: "alert"}, "aria-label" => "close") do
          content_tag(:span, raw("&times;"))
        end + msg
      end
    end

    content_tag(:div, id: "flash-messages") do
      raw content
    end
  end
end
