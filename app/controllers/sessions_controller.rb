class SessionsController < ApplicationController

	def new; end

	def create
		teacher = Teacher.find_by(username: params[:username])
		if teacher && teacher.authenticate(params[:password])
			session[:teacher_id] = teacher.id
			redirect_to teacher_path(teacher)
		else
			flash.now[:alert] = 'Invalid Email or Password'
			 render :new, status: :unprocessable_entity
		end
	end

	def destroy
		session[:teacher_id] = nil
		redirect_to login_path, notice: "Logged out!"
	end
end
