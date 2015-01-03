class Invoice < ActiveRecord::Base
  include SerializeHasMany::Concern
end
