module ArticlesHelper

  def highlight_formatted(hit, field)
    return nil unless hit
    if field_highlight = hit.highlight(field)
      return "#{field_highlight.format {|w| %Q|<span class="highlight">#{w}</span>|}}".html_safe
    end
  end

end
