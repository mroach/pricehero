# Simple helpers for emoji. We'll try not to use this much since it creates
# an inconsistent look across device platforms
module Emoji
  def self.flag(country_code)
    if country_code =~ /\A[A-Z]{2}\z/
      country_code = 'GB' if country_code == 'UK'
      country_code.codepoints.map { |c| (c + 0x1F1A5).chr }.join('')
    else
      country_code
    end
  end
end
