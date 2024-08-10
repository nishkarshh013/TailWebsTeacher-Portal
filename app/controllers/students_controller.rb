class StudentsController < ApplicationController
  before_action :set_teacher, only: %i[create destroy]

  def create
    student_name = normalize_name(student_params[:name])
    subjects_params = student_params[:subjects_attributes]
    
    subjects_params = [subjects_params] unless subjects_params.is_a?(Array)

    subjects_params.each do |subject_params|
      subject_name = normalize_name(subject_params["0"][:name])
      subject_marks = subject_params["0"][:marks].to_i

      # Find existing student with the same name and subject
      existing_student = Student.joins(:subjects)
                                .where('LOWER(students.name) = ?', student_name.downcase)
                                .where('LOWER(subjects.name) = ?', subject_name.downcase)
                                .first

      if existing_student
        subject = existing_student.subjects.find_by('LOWER(name) = ?', subject_name.downcase)
        if subject
          subject.marks = subject_marks
          subject.save
        else
          existing_student.subjects.create(name: subject_name, marks: subject_marks)
        end
        redirect_to teacher_path(@teacher), notice: "Marks updated successfully"
        return
      else
        student = @teacher.students.create(name: student_name)
        subjects_params.each do |subject_params|
          subject_name = normalize_name(subject_params["0"][:name])
          subject_marks = subject_params["0"][:marks].to_i
          student.subjects.create(name: subject_name, marks: subject_marks)
        end
        redirect_to teacher_path(@teacher), notice: "Student and subjects created successfully"
        return
      end
    end

    # Handle the case when no existing student is found (optional)
    redirect_to teacher_path(@teacher), alert: "Student not found"
  end

  def edit
    @subject = Subject.find_by(id: params[:subject_id])
    @student = @subject.student
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

  def normalize_name(name)
    name.to_s.strip.downcase
  end
end
