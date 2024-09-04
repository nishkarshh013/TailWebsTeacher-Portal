class Student < ApplicationRecord
  belongs_to :teacher
  has_many :subjects, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :subjects, allow_destroy: true

  before_create :normalize_name


  def self.check_existing_student(student_name)
    Student.joins(:subjects).where('LOWER(students.name) = ?', student_name.downcase).first
  end

  def existing_subject(subject_name)
    self.subjects.find_by('LOWER(name) = ?', subject_name.downcase)
  end

  def self.update_or_create_student_with_subject(student_name, student_subject, teacher)
    normalized_student_name = downcase_name(student_name)
    subject_marks = student_subject[0]["marks"].to_i
    existing_student = Student.check_existing_student(normalized_student_name)
    if existing_student
      subject = existing_student.existing_subject(student_subject[0]["name"])
      if subject
        subject.marks = subject_marks
        subject.save
      else
        existing_student.subjects.create!(name: student_subject[0]["name"], marks: student_subject[0]["marks"].to_i, student_id: existing_student)
      end
      { notice: "Marks updated successfully", student: existing_student }
    else
      student = teacher.students.create(name: student_name)
      subject = student.subjects.create(marks: subject_marks, name: student_subject[0]["name"])
      { notice: "Student and subjects created successfully", student: student}
    end
  end

  private

  def normalize_name
    self.name = self.name.strip.downcase if self.name.present?
  end

  def self.downcase_name(name)
    name.to_s.strip.downcase
  end
end