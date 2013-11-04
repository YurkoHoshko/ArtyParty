class Party < ActiveRecord::Base
  belongs_to :user
  default_scope :order => 'date DESC'

  def self.next
      self.all.select { |party| party.date.yday >= Date.today.yday}.sort {|x, y| x.date.yday <=> y.date.yday}.first
  end
end
