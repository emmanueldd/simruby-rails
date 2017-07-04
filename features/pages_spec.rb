# -*- coding: utf-8 -*-
##
## pages_spec.rb
## Login : <lta@still>
## Started on  Fri Jun 21 17:42:27 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2013 Lta Akr

require 'spec_helper'

feature 'MiniCMS' do
  given!(:test_page) do
    content = "h1. TestH1
blah blah blah

h2. TestH2

SupaContenta"
    Page.create!(title: 'Test Page', slug: 'test-page', content: content)
  end

  describe 'Display' do
    it 'should displays the Page' do
      visit "/pages/#{test_page.id}"
      expect(page).to have_content 'Test Page'
      expect(page).to have_content 'TestH1'
      expect(page).to have_content 'SupaContenta'
    end

    it 'should interpret and render the content as Textile (redcloth)' do
      visit "/pages/#{test_page.id}"
      expect(page.find('.page-content').find('h1')).to have_content 'TestH1'
      expect(page.find('.page-content').find('h2')).to have_content 'TestH2'
    end

    it 'allows slug in URL instead of id' do
      visit "/pages/#{test_page.slug}"
      expect(page).to have_content 'Test Page'
    end

    it 'displays all the pages link on the menu' do
      visit '/'
      expect(page.find('.pages')).to have_content('Test Page')
    end

    it 'still has a navbar' do
      visit '/'
      expect(page).to have_css('.navbar')
      expect(page).to have_css('ul.nav li a') # This is navbar links
      expect(find 'a.navbar-brand').to have_content('Gazooyr')
    end
  end

  describe 'Edition/Creation' do
    include_context 'authenticated'

    it 'displays a form for page creation' do
      visit new_page_path

      expect(page).to have_content('Création d\'une nouvelle page')
      expect(page).to have_selector('form#new_page')
      expect(page.find('form#new_page')).to have_field('page_title')
      expect(page.find('form#new_page')).to have_field('page_slug')
      expect(page.find('form#new_page')).to have_field('page_content')
      expect(page.find('form#new_page')).to have_button('Sauvegarder')
    end

    it 'allows page creation' do
      visit new_page_path

      within('#new_page') do
        fill_in 'page[title]',   with: 'Page de test'
        fill_in 'page[content]', with: "h1. TestTitle

div(css-test#anId). blahblah

h2. Blahblah

Ceci est un autre test"
        click_on 'Sauvegarder'
      end

      visit('/pages/page-de-test') # Pay attention to automatic slug generation here
      expect(page).to have_content('TestTitle')
      expect(page).to have_css('.css-test')
    end

    it 'displays a form for page edition' do
      visit edit_page_path(test_page)

      expect(page).to have_selector('form#edit_page_1')
      expect(page.find('form#edit_page_1')).to have_field('page_title')
      expect(page.find('form#edit_page_1')).to have_field('page_slug')
      expect(page.find('form#edit_page_1')).to have_field('page_content')
      expect(page.find('form#edit_page_1')).to have_button('Sauvegarder')
    end

    it 'allows page edition' do
      content = 'qweasdzxcqweasdzxcqweasdzxcqweasdzxcqweasdzxc'

      visit edit_page_path(test_page)

      fill_in 'page[content]', with: content
      click_on 'Sauvegarder'

      expect(page).to have_content(content)
    end
  end

  describe 'Acces Rights' do
    it 'required an authenticated user to create page' do
      visit new_page_path
      expect(page).to have_content 'Vous devez vous connecter'
      expect(page).to have_content 'Connection'
      expect(page).to have_selector '#new_user'
    end
    it 'required an authenticated user to edit page' do
      visit edit_page_path(test_page)
      expect(page).to have_content 'Vous devez vous connecter'
      expect(page).to have_content 'Connection'
      expect(page).to have_selector '#new_user'
    end
  end

end
