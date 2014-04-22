class DemoController < ApplicationController

	layout 'admin'

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

end
