require 'spec_helper'
require 'rails_helper'

RSpec.describe Compilebox do
   describe 'get_output' do
      before :each do
        Compilebox.base_uri = "base_uri"
      end 
      it 'should call Compilebox with the correct args' do
         expect(HTTParty).to receive(:post).with("http://base_uri/compile", :body => {"language" => '0', "code" => 'print("hello")', "stdin" => 'stdin'})
         Compilebox.get_output('0', 'print("hello")', 'stdin')
      end
    end
end