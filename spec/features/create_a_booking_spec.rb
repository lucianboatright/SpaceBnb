
feature 'create a booking' do
  scenario 'can see space on booking page' do
    visit('/spaces')
    click_on('List a new space')
    fill_in('name', with: 'Mars house')
    fill_in('price', with: 100)
    fill_in('description', with: 'Very cool house')
    click_on('Submit')
    click_on('Book')
    expect(page).to have_content('Mars house')
  end

  scenario 'can see booking on bookings page' do
    visit('/spaces')
    click_on('List a new space')
    fill_in('name', with: 'Moon house')
    fill_in('price', with: 100)
    fill_in('description', with: 'Moon house')
    click_on('Submit')
    click_on('Book')
    click_on('Submit')
    visit('/bookings')
    expect(page).to have_content('Moon house')
  end


end