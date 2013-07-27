class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :password, :password_confirmation, 
    :male, :first_name, :last_name, :interested_in_male

  has_one :profile_pic, as: :imageable, :class_name => 'Image'
  accepts_nested_attributes_for :profile_pic
  attr_accessible :profile_pic_attributes

  has_many :messages
  has_many :subscriptions

  validates :username, 
    presence: true,
    uniqueness: true

  validates :password,
    confirmation: true, on: :create

  #validates :last_name,
  #  presence: true

  #validates :first_name, 
  #  presence: true

  validates :interested_in_male,
    presence: true


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

  def username=(value)
    write_attribute :username, value.downcase
  end


  def is_male?
    male
  end

  def is_female?
    !male
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
    while @user.id == self.id do 
      @user = User.all.sample(1).first 
    end
    return @user
  end

end
