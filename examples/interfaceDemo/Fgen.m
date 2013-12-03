%Description:
%   The Fgen class allows for control of the Instek GFG-3015 Function Generator inside of 
%   SFU's Ensc Lab1.
%Examples:
%   To use you must first instantiate a Fgen object:
%       fgen = Fgen()
%   After the fgen object is instantiated you now have access to all of the objects internal methods
%       fgen.getFrequency()
%       fgen.setFrequency(3000)
%       fgen.getVoltAmplitude()
%       fgen.setVoltAmplitude(2)
%       fgen.getVoltOffset()
%       fgen.setVoltOffset()
%   To delete the object from the workspace please use Matlabs clear 
%   command. Failure to do so may cause unexpected errors.
%       clear fgen
%Authors:
%   Lester Chee, Ryley Morgan, Jacky Jiang, Yao Li, Joshua Kong, Richard Xie, Jeremy Borys

classdef Fgen < handle
    % these properties are changable by the user
    properties
        waveform = 1;
        frequency = 1000;
        amplitude = 1;
        voltOffset = 0;
        baudRate = 9600;
    end
    
    %private properties are only accessible by calling getter and setters
    properties(Access=private)
        com = -1;
        sweepSetting = 1;
    end
    
    methods
        
        function fgen = Fgen()
        % Description: Constructor method that is called upon instantiation/creation
        % Sets the initial parameters of the function generator
            
            % initialize the com object to talk to. Currently we are assuming that the fgen is
            % connected to COM port 1
            %fgen.com = serial ('COM1');
            
            if fgen.checkConnected()
                fgen.waveform = fgen.getWaveForm();
                fgen.frequency = fgen.getFrequency();
                fgen.amplitude = fgen.getVoltAmplitude();
                fgen.voltOffset = fgen.getVoltOffset();
                fgen.baudRate = fgen.readBaudRate();
            else
                %fgen.com.BaudRate = 19200;
                result = fgen.checkConnected();
                if result
                    disp('***************** ERROR *******************')
                    disp('BaudRate is set to 19200 which is unstable.')
                    disp('Please change the BaudRate on the Function ')
                    disp('Generator to 9600 by pressing the RS232 Button')
                    disp('twice and using the scroll wheel to change the ')
                    disp('BaudRate.')
                    disp('***************** ERROR *******************')
                else
                    disp('***************** ERROR *******************')
                    disp('Could not connect the Function Generator. Please')
                    disp('verify that the Function Generator is plugged into')
                    disp('COM2.')
                    disp('***************** ERROR *******************')
                end
                
            end
        end 
        
        % All methods below reference the the object properties using 'obj' not 'fgen' as in the 
        % constructor method
        
        function retVal = checkConnected(obj)
        % Description: Ensures that the actual function Generator is
        % connected.        
        % Result: Tells the user that the BaudRate for the device is not
        % set correctly.
            % obj.com.timeout = 1;
            %%fopen(obj.com);
            %fprintf(obj.com, '*IDN?');
            
            %res = fscanf(obj.com);
            res = 'Function Generator'
            if strfind(res, 'Function Generator')
                display('SUCCESS: Function Generator connected properly!')
                retVal = 1;
            elseif strfind(res, 'GFG3015')
                display('SUCCESS: Function Generator connected properly!')
                retVal = 1;
            else
                retVal = 0;
            end
            %%fclose(obj.com);
            %obj.com.timeout = 10;
        end

        function com = getCom(obj)
        % Description: Provides an interface for the user to access the com object
        % Example: 
        %   fgen = Fgen();
        %   com = fgen.getCom()
            com = obj.com;
        end
        
        function retVal = readBaudRate(obj)
           fid = fopen('tempBaudRate.txt');
           retVal = fscanf(fid, '%d');
           fclose(fid);
        end
        
        function retVal = getWaveForm(obj)
        % Description: Gets the waveform output from thefunction Generator
        %     the waveforms that the Instek GFG-3015 outputs are
        %     Sinusoid(1), Triangle(2), Square(3)
        % Example:
        %     fgen.getWaveForm()
            fid = fopen('tempWaveform.txt');
            %%fopen(obj.com);
            %cmd = ' :FUNC:WAV ?';
            %%fprintf(obj.com, cmd);
            retVal = fscanf(fid, '%d');
            if (retVal == 1)
                retVal = 'Sinusoid';
            elseif (retVal == 2)
                retVal = 'Triangle';
            elseif (retVal == 3)
                retVal = 'Square';
            end
            fclose(fid);
        end
        
        function retVal = getTriggerPhase(obj)
        % Description: Check the value of the trigger phase
        % Example:
            %fopen(obj.com);
            cmd = [' :SOUR:TRIG:PHAS ?'];
            %fprintf(obj.com, cmd);
            %retVal = str2num(fscanf(obj.com));
            %fclose(obj.com);
        end
      
        function retVal = getTriggerState(obj)
        % Description: Check the trigger state
        % Example:  
            %fopen(obj.com);
            cmd = [' :SOUR:TRIG:STAT ?'];
            %fprintf(obj.com, cmd);
            %retVal = str2num(fscanf(obj.com));
            %fclose(obj.com);
        end
               
        function retVal = getTriggerRate(obj)
        % Description: Check the value of the trigger rate
        % Example: 
            %fopen(obj.com);
            cmd = [' :SOUR:TRIG:RAT ? '];
            %fprintf(obj.com, cmd);
            %retVal = str2num(fscanf(obj.com));
            %fclose(obj.com);
        end
     
        function retVal = getTriggerSpacing(obj)
        % Description: Check the trigger spacing
        % Example:     
            %fopen(obj.com);
            cmd = [' :SOUR:SWE:SPAC ?'];
            %fprintf(obj.com, cmd);
            %retVal = str2num(fscanf(obj.com));
            %fclose(obj.com);
        end        
        
        function retVal = getFrequency(obj)
        % Description: Check the main frequency
        % Example:
            fid = fopen('tempFrequency.txt');
            %cmd = [' :FREQ? '];
            %fprintf(obj.com, cmd);
            retVal = fscanf(fid, '%f');
            %retVal = str2num(fscanf(obj.com));
            %fclose(obj.com);
            fclose(fid);
        end

        function retVal = getVoltAmplitude(obj)
        % Description: Check the value of output amplitude
        % Example:
            fid = fopen('tempVoltAmp.txt');
            %fopen(obj.com);
            cmd = [' :AMPL:VOLT? '];
            retVal = fscanf(fid, '%f');
            %fprintf(obj.com, cmd);
            %retVal = str2num(fscanf(obj.com));
            %fclose(obj.com);
            fclose(fid);
        end
        
        function retVal = getVoltOffset(obj)
        % Description: Check the voltage of offset
        % Example:
            fid = fopen('tempOffset.txt');
            %fopen(obj.com);
            cmd = [' :OFFSet? '];
            retVal = fscanf(fid, '%f');
            %fprintf(obj.com, cmd);
            %retVal = str2num(fscanf(obj.com));
            %fclose(obj.com);
            fclose(fid);
        end
        
        function setFrequency(obj, frequency)
        % Description: Set the main frequency
        % Input Args: Frequency
        % Example:
            fid = fopen('tempFrequency.txt', 'w');
            %cmd = ':FREQ ';
            %cmd = [cmd num2str(frequency)];
            fprintf(fid, '%f', frequency);
            fclose(fid);
            obj.frequency = obj.getFrequency()
        end
        

        function setVoltOffset(obj, offset)
        % Description:
        % Input Args:
        % Example:
        
        %AMPL + (2*OFFSET) <= 10
            if obj.amplitude + abs(2*offset) > 10
                error('myApp:setVoltOffset', 'The voltage offset is larger than the limit')
            
            else
                fid = fopen('tempOffset.txt', 'w');
                fprintf(fid, '%f', offset);
                fclose(fid);
                obj.voltOffset = obj.getVoltOffset()
                %fopen(obj.com);
                cmd = [':OFFSet ' num2str(offset)];
                %fprintf(obj.com, cmd);
                %fclose(obj.com);
            end

        end

        function setVoltAmplitude(obj, voltage)
        % Description: Sets the function generator voltage
        % Input Args: Voltage(Number)
        % Example:
        %   fgen.setVoltAmplitude(1.5)
        
            %need a condition to check invalid voltages.           
            %AMPL + (2*OFFSET) <= 10

            if voltage + abs(2*obj.voltOffset)> 10
                error('myApp:setVoltAmplitude','The voltage amplitude is larger than the set limit')
            elseif voltage <= 0
                error('myApp:setVoltAmplitude','It can not be equal to or below 0')
            else
            %fopen(obj.com);
            fid = fopen('tempVoltAmp.txt', 'w');
            cmd = ':AMPL:VOLT ';
            cmd = [cmd num2str(voltage)];
            fprintf(fid, '%f', voltage);
            fclose(fid);
            %fprintf(obj.com, cmd);
            %fclose(obj.com);
            obj.amplitude = obj.getVoltAmplitude()
            end
        end
        
        function retVal = sweepFrequency(obj)
        % Description:
        % Input Args:
        % Example:
            disp('Function: sweepFrequency not implemented yet. Please Implement.')
        end
        
        function setSweepStartFreq(obj, frequency)
        % Description: Sets the value of sweep start frequency
        % Input Args:
        % Example:
            %fopen(obj.com);
            cmd = ':SOUR:SWE:STAR ';
            cmd = [cmd num2str(frequency)];
            %fprintf(obj.com, cmd);
            %fclose(obj.com);
        end
        
        function retVal = getSweepStartFreq(obj)
        % Description: Check the value of sweep start frequency
        % Input Args:
        % Example:
            %fopen(obj.com);
            cmd = [' :SOUR:SWE:STAR? '];
            %fprintf(obj.com, cmd);
            %retVal = str2num(fscanf(obj.com));
            %fclose(obj.com);
        end
        
        function setSweepStopFreq(obj, frequency)
        % Description: Sets the value of sweep stop frequency
        % Input Args:
        % Example:
            %fopen(obj.com);
            cmd = ':SOUR:SWE:STOP ';
            cmd = [cmd num2str(frequency)];
            %fprintf(obj.com, cmd);
            %fclose(obj.com);
        end
        
        function retVal = getSweepStopFreq(obj)
        % Description: Check the value of sweep stop frequency
        % Input Args:
        % Example:
            %fopen(obj.com);
            cmd = [' :SOUR:SWE:STOP? '];
            %fprintf(obj.com, cmd);
            %retVal = str2num(fscanf(obj.com));
            %fclose(obj.com);
        end
        
        function retVal = sweepOffset(obj, start, finish, numData)
        % Description:sweep a DC OffsetVoltage from start to end
        % Input Args:
        % Example:
            list = linspace(start, finish, numData)
            
            for i = list
                VoltOffset = str2Num(sprintf('%.2f',i))
                obj.setVoltOffset(VoltOffset)
            end
        end
        
        function setSweepRate(obj, rate)
        % Description: Set the value of sweep rate
        % Input Args:
        % Example:            
            %fopen(obj.com);
            cmd = ':SOUR:SWE:RAT ';
            cmd = [cmd num2str(rate)];
            %fprintf(obj.com, cmd);
            %fclose(obj.com);
        end
        
        function retVal = getSweepRate(obj)
        % Description: Check the value of sweep rate
        % Input Args:
        % Example:
            %fopen(obj.com);
            cmd = [' :SOUR:SWE:RAT? '];
            %fprintf(obj.com, cmd);
            %retVal = str2num(fscanf(obj.com));
            %fclose(obj.com);
        end
        
        function retVal = setSweepSym(obj)
        % Description:
        % Input Args:
        % Example:
            disp('Function: setSweepSym not implemented yet. Please Implement.')
        end

        function retVal = setSweepSpacing(obj)
        % Description:
        % Input Args:
        % Example:
            disp('Function: setSweepSpacing not implemented yet. Please Implement.')
        end
        
        function setWaveform(obj, waveform)
        % Description: Sets the Function generator Waveform
        % Input Args: waveform(str) = 'sin', 'tri', 'square'
        % Example:
        %    fgen.setWaveform('tri')
            fid = fopen('tempWaveform.txt', 'w');
            if strcmp(waveform, 'sin')
                fprintf(fid, '%d', 1);
            elseif strcmp(waveform, 'tri')
                fprintf(fid, '%d', 2);
            elseif strcmp(waveform, 'square')
                fprintf(fid, '%d', 3);
            else
                disp('The waveform string must match, waveform = sin, tri, square')
            end
            obj.waveform = obj.getWaveForm();
        end
        
        function delete(obj)
        % Description: delete(obj) is the destructor method for the fgen obj. the methoed is called
        % every time the object is 'cleared'.
            %fclose(obj.com);
        end
        
    end
    
end
