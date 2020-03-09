require 'rails_helper'

RSpec.describe User, type: :model do
  testUser = {
    name: "TEST USER",
    email: "test@user.com",
    password: "TESTPASS",
    password_confirmation: "TESTPASS"
  }


  subject {
    described_class.new(testUser)
  }

  describe 'Validations' do
    
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without matching password_confirmation" do
      subject.password_confirmation = "TESTPASS1"
      expect(subject).to_not be_valid
    end

    it "is not valid without password_confirmation" do
      subject.password_confirmation = ""
      expect(subject).to_not be_valid
    end

    it "is not valid with an un-unique email" do
      test1 = User.new(testUser)
      test1.save
      test2 = User.new({
        name: "TEST USERTWO",
        email: "TEST@user.com",
        password: "TESTPASS1",
        password_confirmation: "TESTPASS1"
      })

      expect(test2).to_not be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a name" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
    
    it "is not valid with a password < 3" do
      subject.password = "aa"
      subject.password_confirmation = "aa"
      expect(subject).to_not be_valid
    end
  end

  describe "authenticat_with_credentials" do
    it "is valid with spaces" do
      User.new(testUser).save
      user = User.authenticate_with_credentials("   test@user.com", subject.password).inspect 
      expect(user).to_not be_nil
    end

    it "is valid with UpperCase" do
      User.new(testUser).save
      user = User.authenticate_with_credentials("   TEST@user.com", subject.password).inspect 
      expect(user).to_not be_nil
    end
  end

end
