require 'spec_helper'

describe UsersController do
  describe "GET new" do
    before do
      get :new
    end
    it "sets @user" do
      expect(assigns(:user)).to be_an_instance_of(User)
    end
    it "renders new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end
      it "sets @user" do
        expect(assigns(:user)).to be_an_instance_of(User)
      end
      it "creates a user" do
        expect(User.count).to eq(1)
      end
      it "sets session[:user_id]" do
        expect(session[:user_id]).to_not be_nil
      end
      it "redirects to dashboard path" do
        expect(response).to redirect_to dashboard_path
      end
      it_behaves_like "success message"
    end
    context "with invalid inputs" do
      before do
        post :create, user: { username: "d" }
      end
      it "sets @user" do
        expect(assigns(:user)).to be_an_instance_of(User)
      end
      it "does not create a user" do
        expect(User.count).to eq(0)
      end
      it "renders new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe "GET edit" do
    context "with authenticated users" do
      before do
        set_current_user
      end
      context "where user is the logged in user" do
        before do
          get :edit, id: current_user.id
        end
        it "sets @user" do
          expect(assigns(:user)).to eq(current_user)
        end
        it "renders edit template" do
          expect(response).to render_template :edit
        end
      end
      context "where user is not the logged in user" do
        let(:bob) { Fabricate(:user, first_name: "Bob") }
        before do
          get :edit, id: bob.id
        end
        it "redirects to dashbboard path" do
          expect(response).to redirect_to dashboard_path
        end
        it_behaves_like "error message"
      end
    end
    context "with unauthenticated users" do
      let(:user) { Fabricate(:user) }
      let(:action) { get :edit, id: user.id }
      it_behaves_like "access denial for unauthenticated users"
    end
  end

  describe "PATCH update" do
    context "with authenticated users" do
      before do
        set_current_user
      end
      context "where user is the logged in user" do
        context "with valid inputs" do
          before do
            patch :update, id: current_user.id, user: { username: "testdummy" }
          end
          it "sets @user" do
            expect(assigns(:user)).to eq(current_user)
          end
          it "updates user correctly" do
            expect(User.first.username).to eq("testdummy")
          end
          it "redirects to dashboard path" do
            expect(response).to redirect_to dashboard_path
          end
          it_behaves_like "success message"
        end
        context "with invalid inputs" do
          before do
            patch :update, id: current_user.id, user: { username: "1" }
          end
          it "sets @user" do
            expect(assigns(:user)).to eq(current_user)
          end
          it "does not update user" do
            expect(User.first.username).to eq("bobby")
          end
          it "renders edit template" do
            expect(response).to render_template :edit
          end
        end
      end
      context "where user is not the logged in user" do
        let(:bob) { Fabricate(:user, first_name: "Bob") }
        let(:action) { patch :update, id: bob.id, user: { first_name: "Jim" } }
        it_behaves_like "access denial for actions not owned by users"
      end
    end
    context "with unauthenticated users" do
      let(:user) { Fabricate(:user) }
      let(:action) { patch :update, id: user.id }
      it_behaves_like "access denial for unauthenticated users"
    end
  end
end
