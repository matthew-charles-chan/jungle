require 'rails_helper'

RSpec.describe Product, type: :model do
  testCat = Category.new(name: "test")
  
  product_params = {
    name: "Anything",
    price: 2000,
    quantity: 10,
    category: testCat
  }
  subject {
    described_class.new(product_params)
  }
  describe 'Validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a price" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a category" do
      subject.category = nil
      expect(subject).to_not be_valid
    end
      
  end
  
end
