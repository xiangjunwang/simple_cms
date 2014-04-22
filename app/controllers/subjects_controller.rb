class SubjectsController < ApplicationController

	layout 'admin'
	
	def index
		list
		render('list')
	end

	def list
		@subjects = Subject.order("subjects.position ASC")
	end

	def show
		@subject = Subject.find(params[:id])
	end

	def new
		@subject = Subject.new(:name => 'default')
	end

	def create
		# Instantiate a new object using form parameters
		@subject = Subject.new(params[:subject])
		# Save the object
		if @subject.save 
			# If save succeeds, refirect to the list action
			flash[:notice] = "Subject created successfully."
			redirect_to(:action => 'list')
		else
			# If save filas, redisplay the form so user can fix problems
			render('new')
		end
	end

	def edit
		@subject = Subject.find(params[:id])
	end

	def update
		# Find a new object using form parameters
		@subject = Subject.find(params[:id])
		# Update the object
		if @subject.update_attributes(params[:subject]) 
			# If save succeeds, refirect to the list action
			flash[:notice] = "Subject updated successfully."
			redirect_to(:action => 'show', :id => @subject.id)
		else
			# If save filas, redisplay the form so user can fix problems
			render('edit')
		end
	end

	def delete
		# Find a new object using form parameters
		@subject = Subject.find(params[:id])
	end

	def destroy
		Subject.find(params[:id]).destroy
		flash[:notice] = "Subject destroyed successfully."
		redirect_to(:action => 'list')
	end

end
