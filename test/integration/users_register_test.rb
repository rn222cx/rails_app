require 'test_helper'

class UsersRegisterTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

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
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    # Valid token, wrong email
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
