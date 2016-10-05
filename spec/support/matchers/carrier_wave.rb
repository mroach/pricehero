require 'rspec/expectations'

# Reverse syntax of include
# e.g. expect(Person.role).to be_included_in ['admin', 'user', 'customer']
RSpec::Matchers.define :have_uploader do |at, uploader|
  match do |actual|
    actual.class.uploaders[at] == uploader
  end

  failure_message do |actual|
    %(expected "#{actual.class}" to have uploader "#{uploader}" at "#{at}")
  end
end
