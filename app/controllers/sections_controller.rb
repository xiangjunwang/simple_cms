class SectionsController < ApplicationController

	layout 'admin'

	before_filter :confirm_logged_in
	before_filter :find_page
	
	def index
		list
		render('list')
	end

	def list
		if @page.nil?
			@page = Page.find(1)
			@sections = Section.sorted
		else
			@sections = Section.sorted.where(:page_id => @page.id)
		end
	end

	def show
		@section = Section.find(params[:id])
	end

	def new
		@section = Section.new
		@page_id_array = Page.order("pages.id ASC").all(:select => :id).collect(&:id)
		@section_count = @page.sections.count + 1
	end

	def create
		new_position = params[:section].delete(:position)
		# Instantiate a new object using form parameters
		@section = Section.new(params[:section])
		# Save the object
		if @section.save 
			@section.move_to_position(new_position)
			# If save succeeds, refirect to the list action
			flash[:notice] = "Section created successfully."
			redirect_to(:action => 'list', :page_id => params[:page_id])
		else
			# If save filas, redisplay the form so user can fix problems
			@section_count = @page.sections.count + 1
			@page_id_array = Page.order("pages.id ASC").all(:select => :id).collect(&:id)
			render('new')
		end
	end

	def edit
		@section = Section.find(params[:id])
		@page_id_array = Page.order("pages.id ASC").all(:select => :id).collect(&:id)
		@section_count = @page.sections.count
	end

	def update
		new_position = params[:section].delete(:position)
		# Find a new object using form parameters
		@section = Section.find(params[:id])
		# Update the object
		if @section.update_attributes(params[:section]) 
			@section.move_to_position(new_position)
			# If save succeeds, refirect to the list action
			flash[:notice] = "Section updated successfully."
			redirect_to(:action => 'show', :id => @section.id, :page_id => params[:page_id])
		else
			# If save filas, redisplay the form so user can fix problems
			@section_count = @page.sections.count
			@page_id_array = Page.order("pages.id ASC").all(:select => :id).collect(&:id)
			render('edit')
		end
	end

	def delete
		# Find a new object using form parameters
		@section = Section.find(params[:id])
	end

	def destroy
		section = Section.find(params[:id])
		section.move_to_position(nil)
		section.destroy
		flash[:notice] = "Section destroyed successfully."
		redirect_to(:action => 'list', :page_id => params[:page_id])
	end

	private

	def find_page
		if params[:page_id]
			@page = Page.find_by_id(params[:page_id])
		end
	end

end
