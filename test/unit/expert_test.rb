require File.dirname(__FILE__) + '/../test_helper'

class ExpertTest < Test::Unit::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  
  fixtures :experts

  def test_should_create_expert
    assert_difference Expert, :count do
      expert = create_expert
      assert !expert.new_record?, "#{expert.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_login
    assert_no_difference Expert, :count do
      u = create_expert(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference Expert, :count do
      u = create_expert(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference Expert, :count do
      u = create_expert(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference Expert, :count do
      u = create_expert(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    experts(:hal).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal experts(:hal), Expert.authenticate('hal', 'new password')
  end

  def test_should_not_rehash_password
    experts(:hal).update_attributes(:login => 'hal2')
    assert_equal experts(:hal), Expert.authenticate('hal2', 'test')
  end

  def test_should_authenticate_expert
    assert_equal experts(:hal), Expert.authenticate('hal', 'test')
  end

  def test_should_set_remember_token
    experts(:hal).remember_me
    assert_not_nil experts(:hal).remember_token
    assert_not_nil experts(:hal).remember_token_expires_at
  end

  def test_should_unset_remember_token
    experts(:hal).remember_me
    assert_not_nil experts(:hal).remember_token
    experts(:hal).forget_me
    assert_nil experts(:hal).remember_token
  end

  def test_should_remember_me_for_one_week
    before = 1.week.from_now.utc
    experts(:hal).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil experts(:hal).remember_token
    assert_not_nil experts(:hal).remember_token_expires_at
    assert experts(:hal).remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    experts(:hal).remember_me_until time
    assert_not_nil experts(:hal).remember_token
    assert_not_nil experts(:hal).remember_token_expires_at
    assert_equal experts(:hal).remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    experts(:hal).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil experts(:hal).remember_token
    assert_not_nil experts(:hal).remember_token_expires_at
    assert experts(:hal).remember_token_expires_at.between?(before, after)
  end

  protected
    def create_expert(options = {})
      Expert.create({ :login => 'quire', :email => 'quire@example.com', :password => 'quire', :password_confirmation => 'quire', :name => "robert", :biography => "swamp monster" }.merge(options))
    end
end
