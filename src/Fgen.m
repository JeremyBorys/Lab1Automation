%Description:
%   The Fgen class allows for control of the Instek GFG-3015 Function Generator inside of 
%   SFU's Ensc Lab1.
%Examples:
%   To use you must first instantiate a Fgen objectL:
%   fgen = Fgen()
%   After the fgen object is instantiated you now have access to all of the objects internal methods
%   fgen.getFrequency()
%   fgen.setFrequency(3000)
%   fgen.getVoltAmplitude()
%   fgen.setVoltAmplitude(2)
%   fgen.getVoltOffset()
%   fgen.setVoltOffset()
%Authors:
%   Lester Chee, Ryley Morgan, Jacky Jiang, Yao Li, Joshua Kong, Richard Xie

classdef Fgen < handle
    % these properties are changable by the user
    properties
        frequency = -1;
        amplitude = -1;
        voltOffset = -1;
        BaudRate = -1;
    end
    
    %private properties are only accessible by calling getter and setters
    properties(access=private)
        com = -1
        sweepSetting = 1
    end
    
    methods
        
        % Description: Constructor method that is called upon instantiation/creation
        % Sets the initial parameters of the function generator
        function fgen = Fgen()
            
            % initialize the com object to talk to. Currently we are assuming that the fgen is
            % connected to COM port 1
            fgen.com = serial ('COM1');
            
            fgen.testBaudRate();
            fgen.checkConnected();
            
            fgen.frequency = fgen.getFrequency();
            fgen.amplitude = fgen.getVoltAmplitude();
            fgen.voltOffset = fgen.getVoltOffset();
            fgen.BaudRate = fgen.com.BaudRate;
            
        end 
        
        % All methods below reference the the object properties using 'obj' not 'fgen' as in the 
        % constructor method
        
        % Description: Ensures that the baudrate is correct
        % Result: Tells the user that the BaudRate for the device is not set correctly
        function testBaudRate(obj)
            disp('Function: testBaudRate not implemented yet. Please Implement.')
        end

        % Description:
        % Example:
        function retVal = getFrequency(obj)
            fopen(obj.com);
            cmd = [' :FREQ? '];
            fprintf(obj.com, cmd);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
        end

        % Description:
        % Example:
        function retVal = getVoltAmplitude(obj)
            fopen(obj.com);
            cmd = [' :AMPL:VOLT? '];
            fprintf(obj.com, cmd);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
        end
        
        % Description:
        % Example:
        function retVal = getVoltOffset(obj)
            fopen(obj.com);
            cmd = [' :OFFSet? '];
            fprintf(obj.com, cmd);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
        end
           
        % Description:
        % Input Args:
        % Example:
        function setFrequency(obj, frequency)
            fopen(obj.com);
            cmd = ':FREQ ';
            cmd = [cmd num2str(frequency)];
            fprintf(obj.com, cmd);
            fclose(obj.com);
        end
        
        % Description:
        % Input Args:
        % Example:
        function setVoltOffset(obj, offset)
            %AMPL + (2*OFFSET) <= 10
            fopen(obj.com);
            cmd = [':OFFSet ' num2str(offset)];
            fprintf(obj.com, cmd);
            fclose(obj.com);
        end

        % Description: Sets the function generator voltage
        % Input Args: Voltage(Number)
        % Example:
        %   fgen.setVoltAmplitude(1.5)
        function setVoltAmplitude(obj, voltage)
            %need a condition to check invalid voltages.           
            %AMPL + (2*OFFSET) <= 10
            fopen(obj.com);
            cmd = ':AMPL:VOLT ';
            cmd = [cmd num2str(voltage)];
            fprintf(obj.com, cmd);
            fclose(obj.com);
        end
        
        % Description:
        % Input Args:
        % Example:
        function err = sweepFrequency(obj)
            disp('Function: sweepFrequency not implemented yet. Please Implement.')
        end
     
        
        % Description: delete(obj) is the destructor method for the fgen obj. the methoed is called
        % every time the object is 'cleared'.
        function delete(obj)
            fclose(obj.com)
        end
        
    end
    
end

