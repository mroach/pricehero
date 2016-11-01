# Helper methods that should be available across all views
module ApplicationHelper
  def new_record_button(type = nil)
    type ||= params[:controller].singularize.to_sym
    return nil unless policy(type).new?
    record_class = type.to_s.camelize.constantize
    link_to [:new, type], class: 'ui primary icon button' do
      content_tag(:i, nil, class: 'plus icon') + t('buttons.new_record', type: record_class.model_name.human)
    end
  end

  def edit_record_button(record)
    return nil unless policy(record).edit?
    link_to [:edit, record], class: 'ui small secondary icon button' do
      content_tag(:i, nil, class: 'edit icon') + t(:edit)
    end
  end

  def timeago(time)
    title = l(time.in_time_zone(t(:timezone)), format: :long)
    timestamp = time.strftime('%F %R')
    content_tag(:time, timestamp, 'data-timestamp': timestamp, title: title)
  end

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
