class PagesController < ApplicationController

	layout 'admin'

	def index
		list
		render('list')
	end

	def list
		@pages = Page.order("pages.position ASC")
	end

	def show
		@page = Page.find(params[:id])
	end

	def new
		@page = Page.new
	end

	def create
		# Instantiate a new object using form parameters
		@page = Page.new(params[:page])
		# Save the object
		if @page.save 
			# If save succeeds, refirect to the list action
			flash[:notice] = "Page created successfully."
			redirect_to(:action => 'list')
		else
			# If save filas, redisplay the form so user can fix problems
			render('new')
		end
	end

	def edit
		@page = Page.find(params[:id])
	end

	def update
		# Find a new object using form parameters
		@page = Page.find(params[:id])
		# Update the object
		if @page.update_attributes(params[:page]) 
			# If save succeeds, refirect to the list action
			flash[:notice] = "Page updated successfully."
			redirect_to(:action => 'show', :id => @page.id)
		else
			# If save filas, redisplay the form so user can fix problems
			render('edit')
		end
	end

	def delete
		# Find a new object using form parameters
		@page = Page.find(params[:id])
	end

	def destroy
		Page.find(params[:id]).destroy
		flash[:notice] = "Page destroyed successfully."
		redirect_to(:action => 'list')
	end

end
