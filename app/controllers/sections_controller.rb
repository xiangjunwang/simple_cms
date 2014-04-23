class SectionsController < ApplicationController

	layout 'admin'

	def index
		list
		render('list')
	end

	def list
		@sections = Sections.order("sections.position ASC")
	end
	
end
