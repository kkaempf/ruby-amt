module Amt
  class Kvm
    def initialize client
      @client = client
      @sap = @client.get "CIM_KVMRedirectionSAP", "Name" => "KVM Redirection Service Access Point"
    end
    def start
      unless @sap.EnabledState
        data = client.get "IPS_KVMRedirectionSettingData", "InstanceID" => "Intel(r) KVM Redirection Settings"
        if data.EnabledByMEBx
          result = sap.RequestStateChange(2)
          if result == 0
            # enable listener
          end
        end
      end
    end

    def status
      data = client.get "IPS_KVMRedirectionSettingData", "InstanceID" => "Intel(r) KVM Redirection Settings"
      if @sap.EnabledState && data.EnabledByMEBx
        puts "KVM enabled" if Amt.debug
      else
        puts "KVM disabled" if Amt.debug
      end
    end
    
    def stop
      if @sap.EnabledState
        data = client.get "IPS_KVMRedirectionSettingData", "InstanceID" => "Intel(r) KVM Redirection Settings"
        result = sap.RequestStateChange(3)
        if result == 0
          # disable listener
        end
      end
    end
  end
end
