class StudentsController < ApplicationController
	before_action :set_teacher, only: %i[index]

	def new
    	@student = Student.new
	end

	def create
	   	@student = @teacher.students.build(student_params)
	    if @student.save
	      redirect_to teacher_path(@teacher), notice: "Student added successfully"
	    else
	      render :new
	    end
	end

	def edit
		@subject = Subject.find_by(id: params[:subject_id])
		@student = @subject.student
	end

	def update
		@student = Student.find_by(id: params[:student][:student_id])
		if @student.update(student_params)
	    redirect_to teacher_path(@student.teacher), notice: 'Student updated successfully.'
	  else
	    render :edit
	  end
	end

	def destroy
		subject = Subject.find_by(id: params[:subject_id])
		@teacher = subject.student.teacher
		subject.destroy
		redirect_to teacher_path(@teacher)
	end

	private

	def set_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end

  def student_params
  	params.require(:student).permit(:name, subjects_attributes: [:id, :name, :marks, :_destroy])
  end
end
