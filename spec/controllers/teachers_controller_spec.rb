# spec/controllers/teachers_controller_spec.rb

require 'rails_helper'

RSpec.describe TeachersController, type: :controller do
  let(:teacher) { create(:teacher) }

  describe 'GET #show' do
    context 'when logged in' do
      before do
        session[:teacher_id] = teacher.id
      end

      it 'assigns @teacher and @students' do
        get :show, params: { id: teacher.id }
        expect(assigns(:teacher)).to eq(teacher)
        expect(assigns(:students)).to eq(teacher.students.includes(:subjects))
      end

      it 'renders the show template' do
        get :show, params: { id: teacher.id }
        expect(response).to render_template(:show)
      end
    end

    context 'when not logged in' do
      it 'redirects to login page' do
        get :show, params: { id: teacher.id }
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq('Please login first')
      end
    end
  end
end
