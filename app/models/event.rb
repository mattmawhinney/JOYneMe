class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attendees
  has_many :users, through: :attendees

  validates_presence_of :description, :neighborhood, :zip_code, :street_address
  validates_length_of   :description, :maximum => 100


    # class method for sorting all events by time 
  def self.order_by_time

    order(datetime: :asc)

  end 



  def has_not_passed? 

    self.datetime.utc > Time.now.utc

  end 


  def date 
    self.datetime.strftime("%A, %B %d")
  end 

  def time 
    self.datetime.strftime("%I")
  end 

end
