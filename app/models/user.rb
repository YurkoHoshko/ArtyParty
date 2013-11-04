class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name, :phone, :date_of_birth

  def self.upcoming
    self.all.select { |user| user.date_of_birth.yday > Date.today.yday}.first
  end

  def self.sorted
    upcoming = self.all.select { |user| user.date_of_birth.yday >= Date.today.yday}.sort {|x, y| x.date_of_birth.yday <=> y.date_of_birth.yday}
    next_year = self.all.select { |user| user.date_of_birth.yday < Date.today.yday}.sort {|x, y| x.date_of_birth.yday <=> y.date_of_birth.yday}
    (upcoming << next_year).flatten
  end
end
