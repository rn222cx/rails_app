require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:roy)
    @user2 = users(:sara)
  end

  test "should redirect to edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "redirect edit when wrong user is logged in" do
    log_in_as(@user2)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@user2)
    patch user_path(@user), params: { user: { email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "redirect to index when not loged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@user2)
    assert_not @user2.king?
    patch user_path(@user2), params: {
                                    user: { password:              "FILL_IN",
                                            password_confirmation: "FILL_IN",
                                            king: true } }
    assert_not @user2.king?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@user2)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "should destroy when logged in as admin" do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@user2)
    end
  end

end
