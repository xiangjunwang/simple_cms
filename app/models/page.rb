class Page < ActiveRecord::Base

	# validations

	# validates_presence_of	:name
	# validates_length_of		:name, :maximum => 255
	# validates_presence_of	:permalink
	# validates_length_of		:permalink, :within => 3..255
	# validates_uniqueness_of	:permalink

	validates :name, :presence => true, :length => { :maximum => 255 }
	validates :permalink, :presence => true, :length => { :within => 3..255 }, :uniqueness => true

	belongs_to :subject
	has_many :sections
	has_and_belongs_to_many :editors, :class_name => "AdminUser"

end
