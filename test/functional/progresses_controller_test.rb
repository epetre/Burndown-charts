require 'test_helper'

class ProgressesControllerTest < ActionController::TestCase
  setup do
    @progress = progresses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:progresses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create progress" do
    assert_difference('Progress.count') do
      post :create, :progress => @progress.attributes
    end

    assert_redirected_to progress_path(assigns(:progress))
  end

  test "should show progress" do
    get :show, :id => @progress.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @progress.to_param
    assert_response :success
  end

  test "should update progress" do
    put :update, :id => @progress.to_param, :progress => @progress.attributes
    assert_redirected_to progress_path(assigns(:progress))
  end

  test "should destroy progress" do
    assert_difference('Progress.count', -1) do
      delete :destroy, :id => @progress.to_param
    end

    assert_redirected_to progresses_path
  end
end
