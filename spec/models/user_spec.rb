require 'spec_helper'

describe User do
  it { expect(subject).to have_many :movies }
  it { expect(subject).to validate_presence_of :username }
  it { expect(subject).to ensure_length_of(:username).is_at_least(2) }
  it { expect(subject).to validate_uniqueness_of(:username).case_insensitive }
  it { expect(subject).to have_secure_password }
  it { expect(subject).to validate_presence_of :password }
  it { expect(subject).to ensure_length_of(:password).is_at_least(4) }
  it { expect(subject).to validate_confirmation_of :password }

  describe ".authenticate(username, password)" do
    context "with valid username and password" do
      let(:user) { Fabricate(:user) }
      it "returns authenticated user" do
        expect(User.authenticate(user.username, user.password)).to eq(user)
      end
    end
    context "with valid username and invalid password" do
      let(:user) { Fabricate(:user) }
      it "returns false" do
        expect(User.authenticate(user.username, "bobislame")).to be_falsey
      end
    end
    context "with invalid username and password" do
      let(:user) { Fabricate(:user) }
      it "returns false" do
        expect(User.authenticate("Jim", "jimiscool")).to be_falsey
      end
    end
  end

  describe "#full_name" do
    context "user has both first and last name present" do
      let(:first_name) { "Bob" }
      let(:last_name) { "Cool" }
      let(:user) { Fabricate(:user, first_name: first_name, last_name: last_name) }
      it "returns first and last name with a space in between" do
        expect(user.full_name).to eq(first_name + " " + last_name)
      end
    end
    context "user only has first name present" do
      let(:first_name) { "Bob" }
      let(:last_name) { nil }
      let(:user) { Fabricate(:user, first_name: first_name, last_name: last_name) }
      it "returns first name only" do
        expect(user.full_name).to eq(first_name)
      end
    end
    context "user only has last name present" do
      let(:first_name) { nil }
      let(:last_name) { "Cool" }
      let(:user) { Fabricate(:user, first_name: first_name, last_name: last_name) }
      it "returns last name only" do
        expect(user.full_name).to eq(last_name)
      end
    end
    context "user does not have first or last name present" do
      let(:first_name) { nil }
      let(:last_name) { nil }
      let(:user) { Fabricate(:user, first_name: first_name, last_name: last_name) }
      it "returns username" do
        expect(user.full_name).to eq(user.username)
      end
    end

    describe "#unwatched_movie" do
      context "user has unwatched movies" do
        let(:user) { Fabricate(:user) }
        let(:movie1) { Fabricate(:movie, user: user) }
        let(:movie2) { Fabricate(:movie, user: user) }
        let(:movie3) { Fabricate(:movie, user: user, watched: true) }
        it "returns list of movies where watched=false" do
          expect(user.unwatched_movies).to eq([movie1, movie2])
        end
      end
      context "user does not have any unwatched movies" do
        let(:user) { Fabricate(:user) }
        let(:movie1) { Fabricate(:movie, user: user, watched: true) }
        let(:movie2) { Fabricate(:movie, user: user, watched: true) }
        it "returns empty array if no movies are found" do
          expect(user.unwatched_movies).to match_array([])
        end
      end
    end
  end

end
