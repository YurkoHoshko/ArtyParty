class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.upcoming
    upcoming = self.all.select { |user| user.date_of_birth.yday > Date.today.yday}
    upcoming.first
  end
end
