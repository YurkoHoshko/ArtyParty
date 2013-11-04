class Party < ActiveRecord::Base
  belongs_to :user

  def self.next
      self.all.select { |party| party.date.yday >= Date.today.yday}.sort {|x, y| x.date.yday <=> y.date.yday}.first
  end
end
