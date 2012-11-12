require 'spec_helper'

# There is no User class within Forem; this is testing the dummy application's class
# More specifically, it is testing the methods provided by Forem::DefaultPermissions
#
# Regression test for #329

describe Admin do

  before(:each) do
    @original_class_name = Forem.user_class
    Forem.user_class = "Admin"
  end

  after(:each) do
    Forem.user_class = @original_class_name.to_s
  end

  it "return class constant" do
    assert_equal Admin, Forem.user_class
  end

  it "it return class as string" do
    assert_equal "Admin", Forem.user_class.to_s
  end

  it "associations reflect on correct class" do
    Forem::Topic.belongs_to :user, :class_name => Forem.user_class_string
    klass = Forem::Topic.reflect_on_association(:user).klass
    klass.should == ::Admin
  end
end
