%Description:
%   The Osc class allows for control of the Tektronix TDS1012 Oscilloscope inside of
%   SFU's Ensc Lab1.
%Examples:
%   To use you must first instantiate an Osc object:
%       osc = Osc()
%   After the osc object is instantiated you now have access to all of the objects internal methods
%       osc.getVoltage()
%       osc.getChannels()
%       osc.getScale()
%       osc.dumpData(filename)
%       osc.dumpScreenshot(filename)
%   To delete the object from the workspace please using Matlabs clear 
%   command. Failure to do so may cause unexpected errors.
%       clear fgen
%Authors:
%   Lester Chee, Ryley Morgan, Jacky Jiang, Yao Li, Joshua Kong, Richard Xie, Jeremy Borys
classdef Osc < handle
    properties
        channels = -1;
        scaleCH1 = -1;
        scaleCH2 = -1;
        baudRate = -1;
        data;
        
    end

    % private properties are only accessible by calling getter and setters
    properties(Access=private)
        com = -1;
    end

    methods

        function osc = Osc()
        % Description: Constructor method that is called upon instantiation/creation
        % Sets the initial parameters of the function generator

            % initialize the com object to talk to. Currently we are assuming that the osc is
            % connected to COM port 1
            osc.com = serial ('COM2');
            
            osc.com.TimeOut = 1;
            osc.com.InputBufferSize = 1000000;
            osc.com.OutputBufferSize = 500000;
            osc.com.Flowcontrol = 'hardware';

            osc.checkConnected();

            osc.channels = osc.getChannels();
            osc.scaleCH1 = osc.getScaleCH1();
            osc.scaleCH2 = osc.getScaleCH2();
            osc.baudRate = osc.com.BaudRate;
            osc.com.TimeOut = 10;

        end

        function setChannel(obj, channel)
        % Description: Changes channels that are being used on the osc
        % Input Args: channel(number): 1, 2, or 3 for channels 1, 2 or both
        % Example:
        %    osc.channel(1) % for channel 1
        %    osc.channel(2) % for channel 2
        %    osc.channel(3) % for both channels
            if channel == 1
                obj.channels = 1;
            elseif channel == 2
                obj.channels = 2;
            elseif channel == 3
                obj.channels = 3;
            else
                disp('Please enter a valid number for 1, 2 or 3 for')
                disp('channels 1, 2 or both')
            end
        end
        
        
        function checkConnected(obj)
        % Description: Ensures that the actual Oscilloscope is connected.
        % Result: Tells the user that the Oscilloscope is connected.
            fopen(obj.com);
            fprintf(obj.com, '*IDN?');
            res = fscanf(obj.com);
            if strfind(res, 'TEKTRONIX')
                display('SUCCESS: Oscilloscope connected properly!')
            else
                display('ERROR: Oscilloscope not connected properly!')
            end
            fclose(obj.com);
        end

        function retVal = dumpData(obj, filename)
        % Description:
        % Input Args:
        % Example:
            disp('Function: dumpData not implemented yet. Please Implement.')
            retVal = filename;
        end

        function retVal = dumpScreenshot(obj, filename)
        % Description:
        % Input Args:
        % Example:
            disp('Function: dumpScreenshot not implemented yet. Please Implement.')
            retVal = filename;
        end

        function retVal = getVoltage(obj)
        % Description: Get the trigger holdoff value
        % Example:
            fopen(obj.com);
            cmd = ['DISplay:FORMat { XY | YT } '];
            fprintf(obj.com, cmd);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
            retVal = -1;
        end

        function retVal = getChannels(obj)
        % Description:
        % Example:
            fopen(obj.com);
            cmd = ['CH<x>? '];
            fprintf(obj.com, cmd);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
        end
        
        function retVal = getCursorDelta(obj)
        % Description: Gets the Distance between two cursors horizontal or vertical
        % Example:
            disp('Function: getChannels not implemented yet. Please Implement.')
            retVal = -1;
        end

        function retVal = getCursorSettings(obj)
        % Description: Gets the vertical or horizontal cursor settings
        % Example:
            disp('Function: getChannels not implemented yet. Please Implement.')
            retVal = -1;
        end

        function retVal = getScaleCH1(obj)
        % Description:
        % Example:
            fopen(obj.com);
            cmd = ['CH1:SCAle?'];
            fprintf(obj.com, cmd);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
        end
        
        function retVal = getScaleCH2(obj)
        % Description:
        % Example:
            fopen(obj.com);
            cmd = ['CH2:SCAle?'];
            fprintf(obj.com, cmd);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
        end
        
        function retVal = getPhase(obj)
        % Description:
        % Example:
            disp('Function: getPhase not implemented yet. Please Implement.')
            retVal = -1;
        end
        
        function com = getCom(obj)
        % Description: Provides an interface for the user to access the com object
        % Example: 
        %   osc = Osc();
        %   osc.getCom
            com = obj.com
        end
        
        function setCursor(obj, inargs)
        % Description: Sets vertical or horizontal cursors on the oscilloscope 
        % Input Args: ??
        % Example:
            disp('Function: setCursor not implemented yet. Please Implement.')
        end

        function delete(obj)
        % Description: delete(obj) is the destructor method for the osc obj. the methoed is called
        % every time the object is 'cleared'. We want to make sure that the com object is closed
        % before the object is cleared from memory.
            fclose(obj.com);
        end

        function retVal = getPk2Pk(obj)
        % Description: Takes the measured Pk2Pk 
        % Input Args: ??
        % Example:
            fopen(obj.com);
            cmd = [':MEASUREMENT:IMMED:TYPE PK2PK '];
            cmd2 = ['MEASUREMENT:IMMED:VALUE? '];
            fprintf(obj.com, cmd);
            fprintf(obj.com, cmd2);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
            
            scale = obj.getScaleCH1()
            if scale > retVal
                obj.setScaleCH1(scale/4)
                retVal = obj.getPk2Pk()
            end
            if scale * 8 < retVal
            
            end
        end
        
        function setScaleCH1(obj, scale)
        % Description: Takes the measured Pk2Pk 
        % Input Args: ??
        % Example:
            fopen(obj.com);
            cmd = 'CH1:SCAle ';
            cmd = [cmd num2str(scale)];
            fprintf(obj.com, cmd);
            fclose(obj.com);
        end
        
        function setScaleCH2(obj, scale)
        % Description: Takes the measured Pk2Pk 
        % Input Args: ??
        % Example:
            fopen(obj.com);
            cmd = 'CH2:SCAle ';
            cmd = [cmd num2str(scale)];
            fprintf(obj.com, cmd);
            fclose(obj.com);
        end           
        
    end % methods

end % classdef
