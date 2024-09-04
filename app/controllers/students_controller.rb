class StudentsController < ApplicationController
  before_action :set_teacher, only: %i[create destroy]

  def create
    subjects_params = params[:student][:subjects_attributes].values
    student_data = Student.update_or_create_student_with_subject(student_params[:name], subjects_params, set_teacher)
    redirect_to teacher_path(@teacher), notice: student_data[:notice]
  end

  def edit
    @errors = []
    @subject = Subject.find_by(id: params[:subject_id])
    @student = @subject.student
    unless @student.teacher.id == params[:teacher_id].to_i
      @errors << "Youre not autherized to edit this user"
    end
  end

  def update
    @student = Student.find_by(id: params[:student][:student_id])
    if @student.update(student_params)
      redirect_to teacher_path(@student.teacher)
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
