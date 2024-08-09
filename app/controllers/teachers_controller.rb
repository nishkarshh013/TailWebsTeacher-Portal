class TeachersController < ApplicationController

	before_action :require_login
	before_action :set_teacher

	def show
    @students = @teacher.students.includes(:subjects)
  end

	private 

	def require_login
		unless session[:teacher_id]
			rediect_to login_path, alert: "Please login first"
		end
	end

	 def set_teacher
    @teacher = Teacher.find(params[:id])
  end
  
end
