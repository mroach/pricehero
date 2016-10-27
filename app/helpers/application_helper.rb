# Helper methods that should be available across all views
module ApplicationHelper
  def page_title
    [content_for(:title), I18n.t(:site_title)].reject(&:blank?).join(' - ')
  end

  def country_description(code)
    bits = []
    bits << 'the' if %w(US GB NL CZ AE DO PH CI GM).include?(code)
    bits << ISO3166::Country[code].try(:name) || code
    bits.join(' ')
  end
end
