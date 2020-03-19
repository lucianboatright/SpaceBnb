feature 'list spaces on Makers BnB' do
  scenario 'see a listing' do
    visit('/spaces')
    expect(page).to have_content('Beautiful relaxing space')
  end

  scenario 'user can click button to list a new space' do
    visit('/spaces')
    expect(page).to have_link("List a new space")
  end

  scenario 'user can view form to make space' do
    visit('/spaces')
    click_link('List a new space')
    expect(page).to have_content("Add a new listing")
  end

    scenario 'fill in form to list new property' do
      visit('/spaces')
      click_on('List a new space')
      fill_in('name', with: 'Old house')
      fill_in('price', with: 100)
      fill_in('description', with: '1920s house')
      click_on('Submit')

      expect(page).to have_content('Old house')
      expect(page).to have_content(100)
      expect(page).to have_content('1920s house')
    end

  end