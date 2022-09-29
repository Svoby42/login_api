require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Uzivatel", email: "uzivatel@seznam.cz",
                     password: "klukujeden", password_confirmation: "klukujeden")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should be saved" do
    @user.name = "pepa"
    @user.email = "olsak@spsmb.cz"
    @user.password = "olsacek"
    @user.password_confirmation = "olsacek"
    @user.save
    assert_equal User.first, @user
  end

  test "should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "seznam.cz"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[abc-d@mail.com abc.def@mail.com abc@mail.com abc_def@mail.com]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address} should be valid"
    end
  end

  test "email validation should not accept invalid addresses" do
    invalid_addresses = %w[abc-@mail.com abc..def@mail.com .abc@mail.com abc#def@mail.com]
    invalid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate = @user.dup
    @user.save
    assert_not duplicate.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "NaZdAr@SeZnAm.cz"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be nonblank" do
    @user.password = @user.password_confirmation = " " * 6
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
