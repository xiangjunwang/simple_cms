class PagesController < ApplicationController

	layout 'admin'

	before_filter :confirm_logged_in
	before_filter :find_subject
	
	def index
		list
		render('list')
	end

	def list
		if @subject.nil?
			@subject = Subject.find(1)
			@pages = Page.sorted
		else
			@pages = Page.sorted.where(:subject_id => @subject.id)
		end
	end

	def show
		@page = Page.find(params[:id])
	end

	def new
		@page = Page.new(:subject_id => @subject.id)
		@subject_id_array = Subject.order("subjects.id ASC").all(:select => :id).collect(&:id)
		@page_count = @subject.pages.size + 1
	end

	def create
		new_position = params[:page].delete(:position)
		# Instantiate a new object using form parameters
		@page = Page.new(params[:page])
		# Save the object
		if @page.save 
			@page.move_to_position(new_position)
			# If save succeeds, refirect to the list action
			flash[:notice] = "Page created successfully."
			redirect_to(:action => 'list', :subject_id => @page.subject_id)
		else
			# If save filas, redisplay the form so user can fix problems
			@page_count = @subject.pages.size + 1
			@subject_id_array = Subject.order("subjects.id ASC").all(:select => :id).collect(&:id)
			render('new')
		end
	end

	def edit
		@page = Page.find(params[:id])
		@subject_id_array = Subject.order("subjects.id ASC").all(:select => :id).collect(&:id)
		@page_count = @subject.pages.size
	end

	def update
		new_position = params[:page].delete(:position)
		# Find a new object using form parameters
		@page = Page.find(params[:id])
		# Update the object
		if @page.update_attributes(params[:page]) 
			@page.move_to_position(new_position)
			# If save succeeds, refirect to the list action
			flash[:notice] = "Page updated successfully."
			redirect_to(:action => 'show', :id => @page.id, :subject_id => @page.subject_id)
		else
			# If save filas, redisplay the form so user can fix problems
			@page_count = @subject.pages.size
			@subject_id_array = Subject.order("subjects.id ASC").all(:select => :id).collect(&:id)
			render('edit')
		end
	end

	def delete
		# Find a new object using form parameters
		@page = Page.find(params[:id])
	end

	def destroy
		page = Page.find(params[:id])
		page.move_to_position(nil)
		page.destroy
		flash[:notice] = "Page destroyed successfully."
		redirect_to(:action => 'list', :subject_id => @subject.id)
	end

	private

	def find_subject
		if params[:subject_id]
			@subject = Subject.find_by_id(params[:subject_id])
		end
	end

end
