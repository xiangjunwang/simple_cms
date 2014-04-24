class DemoController < ApplicationController

	layout 'admin'

	before_filter :confirm_logged_in
	

	def index
		# render(:template => 'demo/hello')
		# redirect_to(:controller => 'demo', :action => 'other_hello')
	end

	def hello
		@array = [1, 2, 3, 4, 5]
		@id = params[:id]
		@page = params[:page]
	end

	def other_hello
		render(:text => 'Hello everyone!')
	end

	def javascript
	end

	def escape_output
	end

	def make_error
		# render(:text => "test"
		# render(:text => @something.upcase)
		# render(:text => "1" + 1)
	end

	def logging
		@subjects = Subject.all
		ActiveSupport::Deprecation.warn("This is a deprecation.")
		logger.debug("This is Debug")
		logger.info("This is Info")
		logger.warn("This is Warn")
		logger.error("This is Error")
		logger.fatal("This is Fatal")
		render(:text => 'Logged!')
	end

end
