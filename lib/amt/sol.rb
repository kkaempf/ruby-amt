module Amt
  class Sol
    def initialize client
      @client = client
      @instance = @client.get "AMT_RedirectionService", "Name" => "Intel(r) AMT Redirection Service"
    end
    
    def start
      res = 0
      case @instance.EnabledState
      when 32770
        puts "SOL is enabled and IDE-R is disabled" if Amt.debug
      when 32771
        puts "SOL and IDE-R are enabled" if Amt.debug
      when 32768
        # SOL and IDE-R are disabled
        puts "Enabling SOL" if Amt.debug
        res = @instance.RequestStateChange(32770)
      when 32769
        # SOL is disabled and IDE-R is enabled
        puts "Enabling SOL" if Amt.debug
        res = @instance.RequestStateChange(32771)
      else
        puts "unknown #{@instance.EnabledState}"
        res = 1
      end      
      res
    end

    def status
      res = 0
      case @instance.EnabledState
      when 32770, 32771 # SOL is enabled and IDE-R is disabled/enabled
        puts "SOL is enabled"
      when 32768, 32769 # SOL is disabled and IDE-R is disabled/enabled
        puts "SOL is disabled"
      else
        puts "unknown #{@instance.EnabledState}"
        res = 1
      end
      res
    end

    def stop
      res = 0
      case @instance.EnabledState
      when 32770
        # SOL is enabled and IDE-R is disabled
        puts "Disabling SOL" if Amt.debug
        res = @instance.RequestStateChange(32768)
      when 32771
        # SOL and IDE-R are enabled
        puts "Disabling SOL" if Amt.debug
        res = @instance.RequestStateChange(32769)
      when 32768
        puts "SOL and IDE-R are disabled" if Amt.debug
      when 32769
        puts "SOL is disabled and IDE-R is enabled" if Amt.debug
      else
        puts "unknown #{@instance.EnabledState}"
        res = 1
      end
    end
  end
end

