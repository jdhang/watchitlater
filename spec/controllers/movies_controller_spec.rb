require 'spec_helper'

describe MoviesController do
  describe "GET new" do
    context "with authenticated users" do
      before do
        set_current_user
        get :new
      end
      it "sets @movie" do
        expect(assigns(:movie)).to be_an_instance_of(Movie)
      end
    end
    context "with unauthenticated users" do
      let(:action) { get :new }
      it_behaves_like "access denial for unauthenticated users"
    end
  end

  describe "POST create" do
    context "with authenticated users" do
      before do
        set_current_user
      end
      context "with valid inputs" do
        before do
          post :create, movie: Fabricate.attributes_for(:movie)
        end
        it "sets @movie" do
          expect(assigns(:movie)).to be_an_instance_of(Movie)
        end
        it "creates a new movie" do
          expect(Movie.count).to eq(1)
        end
        it "creates a new movie for the logged in user" do
          expect(Movie.first.user).to eq(current_user)
        end
      end
      context "with invalid inputs" do
        it "does not create a new movie" do
          post :create, movie: { title: "" }
          expect(Movie.count).to eq(0)
        end
      end
    end
    context "with unauthenticated users" do
      let(:action) { post :create }
      it_behaves_like "access denial for unauthenticated users"
    end
  end

  describe "GET edit" do
    context "with authenticated users" do
      let(:movie) { Fabricate(:movie, user: current_user) }
      before do
        set_current_user
        get :edit, id: movie.id
      end
      it "sets @movie" do
        expect(assigns(:movie)).to eq(movie)
      end
    end
    context "with unauthenticated users" do
      let(:movie) { Fabricate(:movie, user: Fabricate(:user)) }
      let(:action) { get :edit, id: movie.id }
      it_behaves_like "access denial for unauthenticated users"
    end
  end

  describe "PATCH update" do
    context "with authenticated users" do
      before do
        set_current_user
      end
      context "who own the movie" do
        context "with valid inputs" do
          let(:movie) { Fabricate(:movie, user: current_user) }
          before do
            patch :update, id: movie.id, movie: { title: "Avatar" }
          end
          it "sets @movie" do
            expect(assigns(:movie)).to eq(movie)
          end
          it "updates movie correctly" do
            expect(Movie.first.title).to eq("Avatar")
          end
        end
        context "with invalid inputs" do
          let(:movie) { Fabricate(:movie, user: current_user) }
          it "does not update movie" do
            patch :update, id: movie.id, movie: { title: "" }
            expect(Movie.first.title).to eq(movie.title)
          end
        end
      end
      context "who do not own the movie" do
        let(:movie) { Fabricate(:movie, user: Fabricate(:user)) }
        let(:action) { patch :update, id: movie.id, movie: { title: "Avatar" } }
        it_behaves_like "access denial for actions not owned by users"
      end
    end
    context "with unauthenticated users" do
      let(:movie) { Fabricate(:movie) }
      let(:action) { patch :update, id: movie.id, movie: { name: "1" } }
      it_behaves_like "access denial for unauthenticated users"
    end
  end

  describe "DELETE destroy" do
    context "with authenticated users" do
      before do
        set_current_user
      end
      context "who own the movie" do
        let(:movie) { Fabricate(:movie, user: current_user) }
        before do
          delete :destroy, id: movie.id
        end
        it "sets @movie" do
          expect(assigns(:movie)).to eq(movie)
        end
        it "deletes movie" do
          expect(Movie.count).to eq(0)
        end
      end
      context "who do not own the movie" do
        let(:movie) { Fabricate(:movie, user: Fabricate(:user)) }
        let(:action) { delete :destroy, id: movie.id }
        it_behaves_like "access denial for actions not owned by users"
      end
    end
    context "with unauthenticated users" do
      let(:movie) { Fabricate(:movie) }
      let(:action) { patch :update, id: movie.id, movie: { name: "1" } }
      it_behaves_like "access denial for unauthenticated users"
    end
  end

  describe "POST watched" do
    context "with authenticated users" do
      before do
        set_current_user
      end
      context "who own the movie" do
        let(:movie) { Fabricate(:movie, user: current_user) }
        before do
          post :watched, id: movie.id
        end
        it "sets @movie" do
          expect(assigns(:movie)).to eq(movie)
        end
        it "sets watched to true for the movie" do
          expect(Movie.first.watched).to be_truthy
        end
      end
      context "who do not own the movie" do
        let(:movie) { Fabricate(:movie, user: Fabricate(:user)) }
        let(:action) { post :watched, id: movie.id }
        it_behaves_like "access denial for actions not owned by users"
      end
    end
    context "with unauthenticated users" do
      let(:movie) { Fabricate(:movie) }
      let(:action) { post :watched, id: movie.id }
      it_behaves_like "access denial for unauthenticated users"
    end
  end
end
