class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attendees
  has_many :users, through: :attendees

  # def to_local_time

  # 	datetime.utc.use_zone('EDT')

  # end 

  def date 


  end 

  def time 

  end 

end
