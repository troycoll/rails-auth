# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  # makes current.user accessible in view files
  attribute :user
end
