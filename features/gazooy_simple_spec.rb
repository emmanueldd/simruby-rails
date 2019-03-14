##
## gazooy_simple_spec.rb
## Login : <lta@still>
## Started on  Mon Jun 24 19:33:42 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2013 Lta Akr

# This file contains the first features spec series for the actual
# Gazooies (plural of Gazooy)


require 'spec_helper'

feature 'Gazooy Simple' do
  include_context 'authenticated'

  given!(:gazooies) do
    [Gazooy.create!(user_id: user.id, text: 'Je suis un gazooy de test'),
    Gazooy.create!(user_id: user.id, text: 'Je suis un 2e gazooy de test')]
  end

  describe 'Show | Index' do
    it 'displays latest gazooies on the left menu' do
      visit root_path

      expect(page).to have_content gazooies[0].text
      expect(page).to have_content gazooies[1].text
    end

    it 'displays a \'Stream\' link in the navbar to go to gazooies#index' do
      visit root_path

      within('.navbar-default') do
        click_on 'Stream'
      end

      expect(current_path).to eq(gazooies_path)
    end

    it 'displays latest gazooies on gazooies#index' do
      visit gazooies_path

      within('.gazooies-block') do
        expect(page).to have_content gazooies[0].text
        expect(page).to have_content gazooies[1].text
      end
    end

    it 'displays most recent gazooies first' do
      visit gazooies_path

      block = find('.gazooies-block')
      expect(block.text).to match(/#{gazooies[1].text}.+#{gazooies[0].text}/)
    end

    it 'displays the avatar of the post profile near the gazooy' do
      visit gazooies_path

      block = find('.gazooy-block:nth-of-type(1)')
      expect(block).to have_selector('img.avatar')
      expect(block).to have_image(user.profile.avatar.thumb.url)
    end

    it 'allows to click on the avatar to visit the profile of the gazooyr' do
      visit gazooies_path

      within('.gazooy-block:nth-of-type(1)') do
        # Image must be inside the <a> / clickable
        within('a.avatar') { expect(page).to have_selector 'img.avatar' }
        find('img.avatar').trigger 'click'
      end

      expect(page).to have_content "@#{user.email}"
      expect(current_path).to eq(profile_path(user.email))
    end
  end

  describe 'Create', js: true do
    def open_gazooy_form
      visit root_path
      within('.navbar-default') do
        click_on 'Gazooyer'
      end
    end

    scenario 'There\'s a link in the navbar' do
      visit root_path

      within('.navbar-default') do
        expect(page).to have_link 'Gazooyer'
      end
    end

    it 'opens a modal form when you click on \'Gazooyer\''  do
      visit root_path

      # The form is not displayed by default
      expect(page).to have_no_content 'Gazooyez!'
      expect(page).to have_no_field   'gazooy[text]'
      expect(page).to have_no_button  'Envoyer !'

      # Clicking on 'Gazooyer' opens the modal with the form
      within('.navbar-default') do
        click_on 'Gazooyer'
      end

      within('.modal-header') { expect(page).to have_content 'Gazooyez!' }
      within('.modal-body')   { expect(page).to have_field   'gazooy[text]' }
      within('.modal-footer') { expect(page).to have_button  'Envoyer !' }
    end

    it 'creates Gazooy when filling and submitting the form' do
      gz = "Ca gazooy sec !"

      open_gazooy_form

      within('#new_gazooy') do
        fill_in 'gazooy[text]', with: gz
        find('input[type=submit]').trigger 'click'
      end

      visit gazooies_path
      expect(page).to have_content gz
      visit root_path
      expect(page).to have_content gz
    end

    it 'displays a counter of the remaining characters' do
      open_gazooy_form

      within('#new_gazooy') do
        expect(page).to have_content '142'
        fill_in 'gazooy[text]', with: '12'
        expect(page).to have_content '140'
        fill_in 'gazooy[text]', with: '1234567890'
        expect(page).to have_content '132'
      end
    end

    scenario 'A button can dismiss the modal' do
      open_gazooy_form

      within('#new_gazooy_modal') do
        click_on 'Fermer'
      end

      expect(page).to have_no_content 'Envoyer !'
      expect(page).to have_no_content 'Gazooyez!'
      expect(page).to have_no_field   'gazooy[text]'
    end
  end
end
