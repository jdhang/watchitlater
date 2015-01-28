shared_examples "success message" do
  it "flashes success message" do
    expect(flash[:notice]).to_not be_nil
  end
end

shared_examples "error message" do
  it "flashes error message" do
    expect(flash[:error]).to_not be_nil
  end
end

shared_examples "access denial for actions not owned by users" do
  before do
    action
  end
  it "redirects to dashboard path" do
    expect(response).to redirect_to dashboard_path
  end
  it_behaves_like "error message"
end

shared_examples "access denial for unauthenticated users" do
  before do
    clear_current_user
    action
  end
  it "redirects to root path" do
    expect(response).to redirect_to root_path
  end
  it_behaves_like "error message"
end

