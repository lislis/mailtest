module ApplicationHelper

  def flash_class(level)
    case level
      when :notice then "info"
      when :error then "error"
      when :alert then "warning"
      when :success then "success"
    end
  end

  def markdown(text)
    html_renderer = Redcarpet::Render::HTML.new(filter_html: true)

    redcarpet = Redcarpet::Markdown.new(
      html_renderer,
      autolink: true,
      space_after_headers: false,
      underline: true,
    )
    raw redcarpet.render(text)
  end

end
