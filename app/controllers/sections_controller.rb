class SectionsController < ApplicationController

	layout 'admin'

	before_filter :confirm_logged_in
	
	def index
		list
		render('list')
	end

	def list
		@sections = Section.order("sections.position ASC")
	end

	def show
		@section = Section.find(params[:id])
	end

	def new
		@section = Section.new
		@page_id_array = Page.order("pages.id ASC").all(:select => :id).collect(&:id)
		@section_count = Section.count + 1
	end

	def create
		# Instantiate a new object using form parameters
		@section = Section.new(params[:section])
		# Save the object
		if @section.save 
			# If save succeeds, refirect to the list action
			flash[:notice] = "Section created successfully."
			redirect_to(:action => 'list')
		else
			# If save filas, redisplay the form so user can fix problems
			@section_count = Section.count + 1
			@page_id_array = Page.order("pages.id ASC").all(:select => :id).collect(&:id)
			render('new')
		end
	end

	def edit
		@section = Section.find(params[:id])
		@page_id_array = Page.order("pages.id ASC").all(:select => :id).collect(&:id)
		@section_count = Section.count
	end

	def update
		# Find a new object using form parameters
		@section = Section.find(params[:id])
		# Update the object
		if @section.update_attributes(params[:section]) 
			# If save succeeds, refirect to the list action
			flash[:notice] = "Section updated successfully."
			redirect_to(:action => 'show', :id => @section.id)
		else
			# If save filas, redisplay the form so user can fix problems
			@section_count = Section.count
			@page_id_array = Page.order("pages.id ASC").all(:select => :id).collect(&:id)
			render('edit')
		end
	end

	def delete
		# Find a new object using form parameters
		@section = Section.find(params[:id])
	end

	def destroy
		Section.find(params[:id]).destroy
		flash[:notice] = "Section destroyed successfully."
		redirect_to(:action => 'list')
	end

end
