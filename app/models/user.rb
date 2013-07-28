class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :password, :password_confirmation, 
    :description, :male, :first_name, :last_name, :interested_in_male

  has_one :profile_pic, as: :imageable, :class_name => 'Image'
  accepts_nested_attributes_for :profile_pic
  attr_accessible :profile_pic_attributes

  has_many :messages
  has_many :subscriptions, dependent: :destroy
  has_many :pokes, dependent: :destroy

  validates :username, 
    presence: true,
    uniqueness: true

  validates :password,
    confirmation: true, on: :create

  #validates :last_name,
  #  presence: true

  #validates :first_name, 
  #  presence: true

  #validates :interested_in_male,
  #  presence: true


  # Public: downcase username upon create
  #
  # value  - The value of the name
  #
  # Examples
  #
  #   name('AbcDe')
  #   # => 'abcde'
  #
  # Saves name all lowercase

  searchable do 
    text :username, boost: 10
    text :first_name, boost: 7
    text :last_name, boost: 7
    text :description
    boolean :male
  end

  def username=(value)
    write_attribute :username, value.downcase
  end


  def is_male?
    male
  end

  def is_female?
    !male
  end

  def is_interested_in_male?
    interested_in_male
  end

  def is_interested_in_female?
    !interested_in_male
  end
    
  def is_paid?
    paid
  end

  def upgrade
    self.update_attribute(:paid, true)
  end

  # Overwritting default getter
  def messages
    Message.where("sender_id = ? OR receiver_id = ?", self.id, self.id)
  end

  def sent_messages
    Message.where("sender_id = ?", self.id)
  end

  # Get all the messages exchanged between these two people
  def interaction_with(user)
    Message.where("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", self.id, user, user, self.id).order("created_at DESC")
  end

  # Returns all the received messages
  def received_messages
    Message.where("receiver_id = ?", self.id)
  end

  # This is where all the magic will lie, my amazing matching algorithm
  def match
    @user = User.all.sample(1).first
    # Attention: make sure to seed at least on person of each gender
    while !is_match(@user, self) 
      @user = User.all.sample(1).first 
    end
    return @user
  end


  def is_match(user_a, user_b)
    (user_a.is_male? == user_b.is_interested_in_male?) && ( user_b.is_male? == user_a.is_interested_in_male?) && (user_a != user_b)
  end

  def self.better_search(some_text, gender=true)
    self.search do 
      fulltext some_text
      with :male, gender  
    end
  end

  def get_image
    if profile_pic
      return profile_pic.url.thumb.to_s
    else
      return "/assets/default.jpeg"
    end
  end


  def pokes
    Poke.where("pokee_id = ?", self.id)
  end

  def new_pokes
    Poke.where("pokee_id = ? and viewed = ?", self.id, false)
  end


  # Make a array of hashes of poke count at different moment in time
  def poke_history
    poke_history = []
    count = 0
    self.pokes.order("created_at ASC").each do |poke|
      poke_history << {time: poke.created_at, count: count}
      count += 1
    end
    return poke_history
  end
end
