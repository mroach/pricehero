# Helper methods that should be available across all views
module ApplicationHelper
  def page_title
    [content_for(:title), I18n.t(:site_title)].reject(&:blank?).join(' - ')
  end

  def country_description(code)
    bits = []
    bits << 'the' if %w(US GB NL CZ AE DO PH CI GM).include?(code)
    if country = ISO3166::Country[code]
      # For a couple countries, use an alternate name that sounds better
      # e.g. Russia instead of Russian Federation
      # e.g. Macedonia instead of Former Yugoslav Republic of Macedonia
      # e.g. South Korea instead of Korea, Republic of
      bits << (%w(MK RU KR).include?(code) ? country.names.first : country.name)
    else
      bits << code
    end
    bits.join(' ')
  end
end
