class Compilebox
    include HTTParty
    @@base_uri = '54.149.179.253'
    
    def self.get_output(language, code, stdin)
       @@response = HTTParty.post("http://#{@@base_uri}/compile", :body => {"language" => language, "code" => code, "stdin" => stdin})
    end
    
    def self.response
      @@response ||= {}
    end
    
    def self.base_uri= base_uri
        @@base_uri = base_uri
    end
end