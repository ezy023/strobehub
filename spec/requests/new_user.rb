require 'spec_helper'

describe 'user sign in' do
    before do
        visit new_user_path
    end

    it 'should have required fields' do
        expect(page).to have_field "Email", type: "text"
        expect(page).to have_field "Username", type: "text"
        expect(page).to have_field "Password", type: "password"
    end

    it 'can create new user and direct to user\'s page' do
        fill_in 'user_email', with: 'user@email.com'
        fill_in 'user_username', with: 'UserName'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_button 'Save'
        user = User.last
        current_path.should eq user_path(user)
    end

    it 'flashes an error if the user was not created' do
        fill_in 'user_email',    with: 'user@email.com'
        fill_in 'user_username', with: 'UserName'
        fill_in 'user_password', with: 'password'
        click_button 'Save'
        expect {flash[:error]}.to_not be_nil
    end

    it 'keeps user on new sign in page if there were errors' do
        fill_in 'user_email',    with: 'user@email.com'
        fill_in 'user_username', with: 'UserName'
        fill_in 'user_password', with: 'password'
        click_button 'Save'
        current_path.should eq new_user_path
    end

    it 'does not save a new user if required fields are not completed' do
       fill_in 'user_email',    with: 'user@email.com'
       fill_in 'user_username', with: 'UserName'
       fill_in 'user_password', with: 'password'
       click_button 'Save'
       current_path.should eq new_user_path 
   end

   it 'does not allow you to create a user if you already exist' do
      user = FactoryGirl.create(:user)
      fill_in 'user_email',    with: user.email
      fill_in 'user_username', with: user.username 
      fill_in 'user_password', with: user.password
      fill_in 'user_password_confirmation', with: user.password
      click_button 'Save'
      current_path.should eq new_user_path
    end
end
