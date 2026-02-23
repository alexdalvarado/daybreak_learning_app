class Patient < ApplicationRecord
  PRIORITIES = %w[high normal low].freeze

  validates :priority, inclusion: { in: PRIORITIES }

  scope :by_priority, -> {
    order(Arel.sql("CASE priority WHEN 'high' THEN 1 WHEN 'normal' THEN 2 WHEN 'low' THEN 3 END"))
  }
end
