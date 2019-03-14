##
## follow_spec.rb
## Login : <lta@still>
## Started on  Wed Jun 26 11:31:57 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2013 Lta Akr

require 'spec_helper'

feature 'Follower / Followee' do
  include_context 'authenticated'
  given!(:users) do
    (0..2).to_a.map { FactoryGirl.create :user }
  end

  it 'allows to follow people' do
    visit profile_path(users[0].profile)

    expect(page).to have_link 'Follow'
    click_on 'Follow'

    visit profile_path('me')
    expect(page).to have_content '1 Abonnements'
  end

  it 'allows to un-follow people' do
    visit profile_path(users[0].profile)

    expect(page).to have_link 'Follow'
    click_on 'Follow'
    expect(page).to have_link 'Unfollow'
    click_on 'Unfollow'

    visit profile_path('me')
    expect(page).to have_content '0 Abonnements'
  end

  def follow_everyone
    users.each do |u|
      visit profile_path(u.email)
      click_on 'Follow'
    end
    visit profile_path('me')
    expect(page).to have_content '3 Abonnements'
  end

  it 'displays Followers/Followees on dedicated pages' do
    follow_everyone

    # Followees
    visit profile_followees_path('me')
    expect(page).to have_content "Abonnements de @#{user.email}"
    users.each { |u| expect(page).to have_link "@#{u.email}" }

    # Followers
    visit profile_followers_path(users[0].profile)
    expect(page).to have_content "Abonnes de @#{users[0].email}"
    expect(page).to have_link "@#{user.email}"
  end

  it 'displays Followees gazooies in user\'s stream' do
    users.each { |u| Gazooy.create user_id: u.id, text: "Gazooy from @#{u.email}" }

    visit root_path
    within('.navbar-default') { click_on 'Stream' } # gazooies#index

    users.each { |u| expect(page).to have_content "Gazooy from @#{u.email}" }
  end
end
