def set_current_user
  user = Fabricate(:user, username: "bobby")
  session[:user_id] = user.id
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def login(a_user=nil)
  user = a_user ||= Fabricate(:user)
  visit root_path
  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_button "Login"
end
