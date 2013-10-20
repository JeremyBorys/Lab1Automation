classdef Fgen
    %FGEN Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        frequency = 1
        amplitude = 1
        voltageOffset = 1
        sweepSetting = 1
    end
    
    methods
        function err = testBaudRate(obj)
            err = -1
        end
        function err = sweepFrequency(obj)
            err = -1
        end
        function err = getFrequency(obj)
            err = -1
        end
        function err = setFrequency(obj)
            err = -1
        end
    end
    
end

