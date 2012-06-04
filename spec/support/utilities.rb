# Full title for  RSpec
def full_title(page_title)
  base_title = "tKiero Demo App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(user)
  visit login_path
  fill_in "email",    with: user.email
  fill_in "password", with: user.password
  click_button "Log In"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = user.remember_token
end