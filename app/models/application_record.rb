# Base class for standard ActiveRecord model inheritance
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
