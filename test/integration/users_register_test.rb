require 'test_helper'

class UsersRegisterTest < ActionDispatch::IntegrationTest

  test "invalid signup form" do
    get register_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { email: "user@invalid.com",
                                        password: "1234",
                                        password_confirmation: "12345"}}
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get register_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    #assert_template 'users/show'
    #assert is_logged_in?
  end
end
