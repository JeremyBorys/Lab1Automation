%Description:
%Examples:
%Authors

classdef Fgen
    % these properties are changable by the user
    properties
        frequency = -1;
        amplitude = -1;
        voltOffset = -1;
        BaudeRate = -1;
    end
    
    %private properties are only accessible by calling getter and setters
    properties(access=private)
        com = -1
        sweepSetting = 1
    end
    
    methods
        
        function fgen = Fgen()
            
            % initialize the com object to talk to
            fgen.com = serial ('COM1');
            
            fgen.testBaudRate();
            
            fgen.frequency = getFrequency();
            fgen.amplitude = getVoltAmplitude();
            fgen.voltOffset = getVoltOffset();
            
        end 
        
        % Sets the function generator voltage
        function setFGenVolt (obj, voltage)
            
            %need a condition to check invalid voltages.           
            %AMPL + (2*OFFSET) <= 10
            fopen(obj.com);
            cmd = ':AMPL:VOLT ';
            cmd = [cmd num2str(voltage)];
            fprintf(obj.com, cmd);
            fclose(obj.com);
        end
        
        function retVal = getVoltAmplitude(obj)
            fopen(obj.com);
            cmd = [' :AMPL:VOLT? '];
            fprintf(obj.com, cmd);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
        end
        
        function testBaudRate(obj)
            disp('Function: testBaudRate not implemented yet. Please Implement.')
        end
        
        function err = sweepFrequency(obj)
            disp('Function: sweepFrequency not implemented yet. Please Implement.')
        end
        
        function setFrequency(obj, frequency)
            fopen(obj.com);
            cmd = ':FREQ ';
            cmd = [cmd num2str(frequency)];
            fprintf(obj.com, cmd);
            fclose(obj.com);
        end
        
        function getFrequency(obj)
            fopen(obj.com);
            cmd = [' :FREQ? '];
            fprintf(obj.com, cmd);
            sample = str2num(fscanf(obj.com));
            fclose(obj.com);
        end
        
        function setVoltOffset( obj, offset )
            %AMPL + (2*OFFSET) <= 10
            fopen(obj.com);
            cmd = [':OFFSet ' num2str(offset)];
            fprintf(obj.com, cmd);
            fclose(obj.com);
        end

        function getVoltOffset(obj)
            fopen(obj.com);
            cmd = [' :OFFSet? '];
            fprintf(obj.com, cmd);
            sample = str2num(fscanf(obj.com));
            fclose(obj.com);
        end
    end
    
end

