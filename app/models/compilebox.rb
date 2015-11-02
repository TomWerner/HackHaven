class Compilebox 
    include HTTParty
    
    class Compilebox::NetworkError < RuntimeError; end;

    
    @@base_uri = '54.149.179.253'
    
    def self.get_output(language, code, stdin)
        begin
            @@response = HTTParty.post("http://#{@@base_uri}/compile", :body => {"language" => language, "code" => code, "stdin" => stdin})
            return self.response
        rescue Errno::ECONNREFUSED => e
            raise Compilebox::NetworkError.new(e)
        end
    end
    
    def self.get_languages
        begin
            @@response = HTTParty.get("http://#{@@base_uri}/languages")
            return self.response["languages"]
        rescue Errno::ECONNREFUSED => e
            raise Compilebox::NetworkError.new(e)
        end
    end
    
    def self.response
      @@response ||= {}
    end
    
    def self.base_uri= base_uri
        @@base_uri = base_uri
    end
    
    def self.get_test_pairs(question_id)
        testcases = Question.find(question_id).testcases
        result = []
        testcases.each { |testcase| result.push([testcase.stdin, testcase.stdout]) }
        return result
    end
    
    def self.submit_code(question_id, language_id, code)
        test_pairs = self.get_test_pairs(question_id)
        results = []
        
        test_pairs.each do |test_pair|
            self.get_output(language_id, code, test_pair[0])
            if self.error?
                results.push(self.error_message)
            elsif self.wrong_output?(test_pair[1])
                results.push(self.wrong_output_message(test_pair[1]))
            else
                results.push(self.correct_message)
            end
        end
        
        return results
    end
    
    def self.parse_error
        self.response["errors"]
    end
    
    def self.error?
        !self.parse_error.empty?
    end
    
    def self.error_message
        "Error running test case:\n\n#{self.parse_error}"
    end
    
    def self.parse_output
        self.response["output"]
    end
    
    def self.wrong_output?(expected_output)
        self.parse_output.gsub(/\r\n/, "\n").chomp != expected_output.gsub(/\r\n/, "\n").chomp
    end
    
    def self.wrong_output_message(expected_output)
        "Incorrect Answer:\n\nExpected:\n#{expected_output}\nActual:\n#{self.parse_output}"
    end
    
    def self.correct_message
        "Correct!"
    end
end