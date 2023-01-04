class EmptyController < ApplicationController
	skip_before_action :doorkeeper_authorize!

	include SimpleAuthentication::Controllers::SimpleAuth
end
