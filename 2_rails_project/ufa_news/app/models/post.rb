class Post < ApplicationRecord
  scope :traffic, -> { where(category: 'traffic')}
  scope :sport, -> { where(category: 'sport')}
  scope :gov, -> { where(category: 'gov')}
end
