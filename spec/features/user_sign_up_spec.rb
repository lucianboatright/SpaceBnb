feature 'Register for MakersBnB' do
  scenario 'User registers for MakersBnB' do
    visit '/register'
    fill_in :first_name, with: 'John'
    fill_in :last_name, with: 'Smith'
    fill_in :email, with: 'JS@gmail.com'
    click_on 'Register'
    expect(page).to have_content 'John, we have lift off!'
  end
end

