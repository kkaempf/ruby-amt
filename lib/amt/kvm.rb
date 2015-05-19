module Amt
  class Kvm
    def initialize client
      @client = client
      @sap = @client.get "CIM_KVMRedirectionSAP", "Name" => "KVM Redirection Service Access Point"
    end

    # https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/WordDocuments/enablingkvm.htm
    def start
      res = 0
      unless @sap.EnabledState == 2
        puts "enabling KVM" if Amt.debug
        data = @client.get "IPS_KVMRedirectionSettingData", "InstanceID" => "Intel(r) KVM Redirection Settings"
        if data.EnabledByMEBx
          unless data.Is5900PortEnabled
            data.Is5900PortEnabled = true
            data.RFBPassword = "P@ssw0rd"
            data.put!
          end
          res = @sap.RequestStateChange(2)
          if res == 0
            # https://software.intel.com/sites/manageability/AMT_Implementation_and_Reference_Guide/WordDocuments/changethelistenerenabledsetting.htm
            listener = @client.get "AMT_RedirectionService", "Name" => "Intel(r) AMT Redirection Service"
            unless listener.ListenerEnabled
              listener.ListenerEnabled = true
              listener.put!
            end
          else
            STDERR.puts "RequestStateChange(2) failed"
          end
        else
          puts "Please enable AMT in the BIOS"
        end
      else
        puts "KVM enabled" if Amt.debug
      end
      res
    end

    def status
      case @sap.EnabledState
      when 2
        puts "KVM enabled"
        data = @client.get "IPS_KVMRedirectionSettingData", "InstanceID" => "Intel(r) KVM Redirection Settings"
        if data.Is5900PortEnabled
          puts "Listening on port 5900"
        else
          puts "Listening on port 16993(non-TLS)/16994(TLS)"
        end
      when 3
        puts "KVM disabled"
      when 4
        puts "KVM shutting down"
      when 6
        puts "KVM enabled but offline"
      when 10
        puts "KVM starting up"
      else
        puts "Unknown state #{@sap.EnabledState}"
      end
      0
    end
    
    def stop
      res = 0
      unless @sap.EnabledState == 3
        puts "disabling KVM" if Amt.debug
        data = @client.get "IPS_KVMRedirectionSettingData", "InstanceID" => "Intel(r) KVM Redirection Settings"
        res = @sap.RequestStateChange(3)       
      else
        puts "KVM disabled" if Amt.debug
      end
      res
    end
  end
end
