feature 'log in' do
  scenario 'user can log in with their details' do
    User.add(first_name: "Darth", last_name: "Vader", email: "darth.vader@space.com", password: "dark123")
    
    visit '/session'
    fill_in(:email, with: "darth.vader@space.com")
    fill_in(:password, with: "dark123")
    click_button('Sign in')

    expect(page).to have_content 'Welcome to the Milky Way, Darth Vader.'
  end
end
