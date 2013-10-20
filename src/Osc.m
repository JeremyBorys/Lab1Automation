classdef Osc
    %FGEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    BaudRate = 1;
    Channels = 1;
    Data;
    end
   
    
    methods
        function err = testBaudrate(obj)
            obj.BaudRate = 1 + obj.BaudRate;
            err = obj.BaudRate;
        end
        function err = getVoltage(obj)
            err = -1;
        end
        function err = getScale(obj)
        err = -1;
        end
        
        function err =  setScale(obj)
            err = -1;
        end
        function err = dumpData(obj)
            err = -1;
        end
        function err = dumpScreenshot(obj)
            err = -1;
        end
    end
    
end

