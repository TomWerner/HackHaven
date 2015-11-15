require 'rails_helper'

RSpec.describe Registration, type: :model do
  describe 'not already registered' do
      before :each do
          Registration.create!(:userid => "17", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "Fake", :team => "Volta")
      end
      it 'should fail when already registered' do
          @fake_reg = Registration.new(:userid => "17", :firstname => "Fake", :lastname => "fake", :email => "fake_email", :year => "fake", :major => "fake", :contestname => "Fake", :team => "Volta")
          @fake_reg.valid?
          expect(@fake_reg.save).to eq false
      end
  end
end
