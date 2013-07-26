class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :password, :password_confirmation, :male

  has_one :profile_pic, as: :imageable, :class_name => 'Image'
  accepts_nested_attributes_for :profile_pic
  attr_accessible :profile_pic_attributes

  validates :username, 
    presence: true,
    uniqueness: true

  validates :password,
    confirmation: true, on: :create

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

  def name=(value)
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

end
