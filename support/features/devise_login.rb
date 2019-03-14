##
## devise_login.rb
## Login : <lta@still>
## Started on  Sat Jun 22 17:52:50 2013 Lta Akr
## $Id$
##
## Author(s):
##  - Lta Akr <>
##
## Copyright (C) 2013 Lta Akr
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
##

require 'spec_helper'

if defined? User
  shared_context 'authenticated' do
    given! :user do
      User.create!(email: 'test@example.com',
                   password: 'qweasd', password_confirmation: 'qweasd')
    end
    before(:each) do
      visit new_user_session_path

      within('#new_user') do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        check 'user[remember_me]'

        click_on "Sign in"
      end
    end
  end
else
  shared_context 'authenticated' do
    puts "User doesn't exist. Devise might not be implemented yet"
  end
end
