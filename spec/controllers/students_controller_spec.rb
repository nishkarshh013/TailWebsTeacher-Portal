require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:teacher) { create(:teacher) }

  let(:valid_attributes) do
    {
      student: {
        name: "Jane Doe",
        subjects_attributes: {
          "0" => {
            name: "Science",
            marks: 95
          }
        }
      },
      teacher_id: teacher.id
    }
  end

  let(:invalid_attributes) do
    {
      student: {
        name: "",
        subjects_attributes: {
          "0" => {
            name: "",
            marks: -10
          }
        }
      },
      teacher_id: teacher.id
    }
  end

  before do
    session[:teacher_id] = teacher.id  # Simulate logged-in teacher
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Student with subjects" do
        expect {
          post :create, params: valid_attributes
        }.to change(Student, :count).by(1)  # Change in Student count

        student = Student.last
        expect(student.name).to eq("jane doe")
        expect(student.subjects.first.name).to eq("Science")
        expect(student.subjects.first.marks).to eq(95)
      end

      it "redirects to the teacher's show page with success notice" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(teacher_path(teacher))
        expect(flash[:notice]).to eq("Student and subjects created successfully")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Student" do
        expect {
          post :create, params: invalid_attributes
        }.to_not change(Student, :count)
      end

      it "renders the new template with an error message" do
        post :create, params: invalid_attributes
        expect(response).to redirect_to(teacher_path(teacher))
        expect(flash[:alert]).to eq("Student not found")
      end
    end
  end
end
