module Emoji
  def self.flag(country_code)
    if country_code =~ /\A[A-Z]{2}\z/
      country_code = 'GB' if country_code == 'UK'
      country_code.codepoints.map { |c| (c + 127397).chr }.join('')
    else
      country_code
    end
  end
end
