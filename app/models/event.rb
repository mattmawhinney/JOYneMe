class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attendees
  has_many :users, through: :attendees


    # class method for sorting all events by time 
  def self.order_by_time

    order(datetime: :asc)

  end 



  def has_not_passed? 

    self.datetime.utc > Time.now.utc

  end 




  # def to_utc

  # 	datetime.utc

  # end 

  def date 


  end 

  def time 

  end 

end
