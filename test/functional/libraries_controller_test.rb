require File.dirname(__FILE__) + '/../test_helper'
require 'libraries_controller'

# Re-raise errors caught by the controller.
class LibrariesController; def rescue_action(e) raise e end; end

class LibrariesControllerTest < Test::Unit::TestCase
  fixtures :libraries

  def setup
    @controller = LibrariesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @first_id = libraries(:first).id
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:libraries)
  end

  def test_show
    get :show, :id => @first_id

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:library)
    assert assigns(:library).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:library)
  end

  def test_create
    num_libraries = Library.count

    post :create, :library => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_libraries + 1, Library.count
  end

  def test_edit
    get :edit, :id => @first_id

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:library)
    assert assigns(:library).valid?
  end

  def test_update
    post :update, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => @first_id
  end

  def test_destroy
    assert_nothing_raised {
      Library.find(@first_id)
    }

    post :destroy, :id => @first_id
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Library.find(@first_id)
    }
  end
end
