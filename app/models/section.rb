require 'position_mover'

class Section < ActiveRecord::Base

	include PositionMover

	# validations
	CONTENT_TYPES = ['text', 'HTML']

	# validates_presence_of	:name
	# validates_length_of		:name, :maximum => 255
	# validates_inclusion_of	:content_type, :in => CONTENT_TYPES, :message => "must be one of: #{CONTENT_TYPES.join(', ')}"
	# validates_presence_of	:content

	validates :name, :presence => true, :length => { :maximum => 255 }, :uniqueness => true
	validates :content_type, :inclusion => { :in => CONTENT_TYPES, :message => "must be one of: #{CONTENT_TYPES.join(', ')}"}
	validates :content, :presence => true

	belongs_to :page
	has_many :section_edits
	has_many :editors, :through => :section_edits, :class_name => "AdminUser"

	scope :visible, where(:visible => true)
	scope :invisible, where(:visible => false)
	scope :sorted, order('sections.position ASC')

	private

	def position_scope
		"sections.page_id = #{page_id.to_i}"
	end

end
