require 'spec_helper'
require 'rails_helper'

RSpec.describe Compilebox do
   before :each do
     Compilebox.base_uri = "base_uri"
   end 
      
   describe 'get_output' do
      it 'should call Compilebox with the correct args' do
         expect(HTTParty).to receive(:post).with("http://base_uri/compile", :body => {"language" => '0', "code" => 'print("hello")', "stdin" => 'stdin'})
         Compilebox.get_output('0', 'print("hello")', 'stdin')
      end
      it 'should raise a network error if there is no connection' do
         expect(HTTParty).to receive(:post).and_raise(Errno::ECONNREFUSED)
         expect{Compilebox.get_output('','','')}.to raise_error(Compilebox::NetworkError)
      end
    end
      
   describe 'get_languages' do
      it 'should call Compilebox' do
         fake_results = {"languages" => ['Python', 'Java']}
         expect(HTTParty).to receive(:get).with("http://base_uri/languages").and_return(fake_results)
         expect(Compilebox.get_languages()).to eq(fake_results["languages"])
      end
      it 'should raise a network error if there is no connection' do
         expect(HTTParty).to receive(:get).and_raise(Errno::ECONNREFUSED)
         expect{Compilebox.get_languages}.to raise_error(Compilebox::NetworkError)
      end
    end
    
    describe 'submit_code' do
       it 'should get the test pairs' do
          expect(Compilebox).to receive(:get_test_pairs).with(1).and_return([])
          Compilebox.submit_code(1, 0, '')
       end
       it 'should submit code for each test case (error)' do
          test_pairs = [['3', "*\n**\n***"]]
          code = '#test code'
          api_result = {"output"=>"", "langid"=>"0", "code"=>code, "errors"=>"There was an error", "time"=>" .03\n"}
          api_call_body = {:body => {"language" => '0', "code" => code, "stdin" => test_pairs[0][0]}}
          expect(Compilebox).to receive(:get_test_pairs).with(1).and_return(test_pairs)
          expect(HTTParty).to receive(:post).with("http://base_uri/compile", api_call_body).and_return(api_result)
          
          result = Compilebox.submit_code(1, "0", code)
          expect(result.length).to eq(1)
          expect(result[0]).to eq("Error running test case:\n\nThere was an error")
       end
       it 'should submit code for each test case (wrong output)' do
          test_pairs = [['3', "*\n**\n***"]]
          code = '#test code'
          api_result = {"output"=>"***\n**\n*", "langid"=>"0", "code"=>code, "errors"=>"", "time"=>" .03\n"}
          api_call_body = {:body => {"language" => '0', "code" => code, "stdin" => test_pairs[0][0]}}
          expect(Compilebox).to receive(:get_test_pairs).with(1).and_return(test_pairs)
          expect(HTTParty).to receive(:post).with("http://base_uri/compile", api_call_body).and_return(api_result)
          
          result = Compilebox.submit_code(1, "0", code)
          expect(result.length).to eq(1)
          expect(result[0]).to eq("Incorrect Answer:\n\nExpected:\n*\n**\n***\nActual:\n***\n**\n*")
       end
       it 'should submit code for each test case (correct output)' do
          test_pairs = [['3', "*\n**\n***"]]
          code = '#test code'
          api_result = {"output"=>"*\n**\n***", "langid"=>"0", "code"=>code, "errors"=>"", "time"=>" .03\n"}
          api_call_body = {:body => {"language" => '0', "code" => code, "stdin" => test_pairs[0][0]}}
          expect(Compilebox).to receive(:get_test_pairs).with(1).and_return(test_pairs)
          expect(HTTParty).to receive(:post).with("http://base_uri/compile", api_call_body).and_return(api_result)
          
          result = Compilebox.submit_code(1, "0", code)
          expect(result.length).to eq(1)
          expect(result[0]).to eq("Correct!")
       end
    end
    
    describe "get_test_pairs" do
       it "should return the stdin and stdout pairs" do
          question = Question.create(title: "Title", description: "Question")
          expect(Question).to receive(:find).with("123").and_return(question)
          testcases = [Testcase.create(stdin: "in1", stdout: "out1"),
                        Testcase.create(stdin: "in2", stdout: "out2"),
                        Testcase.create(stdin: "in3", stdout: "out3")]
          expect(question).to receive(:testcases).and_return(testcases)
          
          results = Compilebox.get_test_pairs("123")
          
          expect(results[0]).to eq(["in1", "out1"])
          expect(results[1]).to eq(["in2", "out2"])
          expect(results[2]).to eq(["in3", "out3"])
       end
    end
end