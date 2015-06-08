module Amt
  class Version
    def initialize client
      @client = client
    end
    
    def status
      puts "Protocol_version '#{@client.protocol_version}'"
      puts "Product vendor '#{@client.product_vendor}'"
      puts "Product version '#{@client.product_version}'"
      0
    end
  end
end

