# -*- coding: utf-8 -*-
##
## profile_spec.rb
## Login : <lta@still>
## Started on  Mon Jun 24 14:10:25 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2013 Lta Akr

require 'spec_helper'

feature 'Profile' do
  include_context 'authenticated'
  background do
    user.profile.name = "Real Name"
    user.profile.place = "DTC"
    user.profile.website = "http://www.facebook.com/real.name"
    user.profile.bio = "I like Justin Bieber and Madonna"
    user.profile.save!
  end

  it 'can show a profile' do
    visit profile_path(user.profile)

    expect(page).to have_content "@#{user.email}"
    expect(page).to have_content user.profile.name
    expect(page).to have_content user.profile.place
    expect(page).to have_content user.profile.website
    expect(page).to have_content user.profile.bio
  end


  it 'allows to use \'me\' to access currently logged in user\'s profile' do
    visit profile_path('me')
    expect(page).to have_content "@#{user.email}"
  end

  it 'displays a link in the navbar to \'/profiles/me\'' do
    visit root_path
    expect(page).to have_content 'Moi'
    click_on 'Moi'
    expect(page).to have_content "@#{user.email}"
    expect(page).to have_content user.profile.bio
  end

  it 'display a link to profile edition in the navbar', js: true do
    visit root_path
    expect(page).to have_content :all, 'Mon Profile'

    within('.navbar') do
      click_on 'account-dropdown' # Bootstrap's %a.dropdown-toggle must have id #account-dropdown
      click_on 'Mon Profile'
    end
    expect(current_path).to eq(edit_profile_path('me'))
  end

  it 'allows profile edition' do
    visit edit_profile_path('me')

    within '#edit_profile_1' do
      fill_in 'profile[name]',    with: 'Francis La Saucisse'
      fill_in 'profile[place]',   with: 'Deeper than that'
      fill_in 'profile[website]', with: 'http://www.perdu.com'
      fill_in 'profile[bio]',     with: 'J\'aime la choucroute'
      click_on 'Mettre à jour !'
    end

    expect(page).to have_content "Votre profil a bien été mis-à-jour"
    expect(page).to have_content "Francis"
    expect(page).to have_content "Deeper"
    expect(page).to have_content "perdu.com"
    expect(page).to have_content "choucroute"
  end

  it 'allows avatar upload' do
    visit edit_profile_path('me')

    file = File.join(::Rails.root, 'spec', 'support', 'features', 'avatar.png')
    within '#edit_profile_1' do
      attach_file 'profile[avatar]', file
      click_on 'Mettre à jour !'
    end
    expect(page).to have_content "Votre profil a bien été mis-à-jour"
    expect(user.profile.reload.avatar.to_s).to match(/avatar\.png/)
  end

  it 'diplays a link to the edit page if logged and on my profile page' do
    visit profile_path('me')
    expect(page).to have_link 'Editer'
    click_on 'Editer'
    expect(current_path).to eq(edit_profile_path('me'))

    u = User.create email: 'pwet@email.fr', password: 'qweasd', password_confirmation: 'qweasd'
    visit profile_path(u)
    expect(page).to have_no_link 'Editer'
  end
end
