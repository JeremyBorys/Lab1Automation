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
        scale = -1;
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
            
            osc.com.InputBufferSize = 1000000;
            osc.com.OutputBufferSize = 500000;
            osc.com.Flowcontrol = 'hardware';

            osc.testBaudRate();
            osc.checkConnected();

            osc.channels = osc.getChannels();
            osc.scale = osc.getScale();
            osc.baudRate = osc.com.BaudRate;

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

        function testBaudRate(obj)
        % Description: Ensures that the baudrate is correct
        % Result: Tells the user that the BaudRate for the device is not set correctly
            disp('Function: testBaudRate not implemented yet. Please Implement.')
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
        % Description:
        % Example:
            disp('Function: getVoltage not implemented yet. Please Implement.')
            retVal = -1;
        end

        function retVal = getChannels(obj)
        % Description:
        % Example:
            disp('Function: getChannels not implemented yet. Please Implement.')
            retVal = -1;
        end

        function retVal = getScale(obj)
        % Description:
        % Example:
            disp('Function: getScale not implemented yet. Please Implement.')
            retVal = -1;
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
        
        function setScale(obj, inargs)
        % Description:
        % Input Args:
        % Example:
            disp('Function: setScale not implemented yet. Please Implement.')
        end

        function delete(obj)
        % Description: delete(obj) is the destructor method for the osc obj. the methoed is called
        % every time the object is 'cleared'. We want to make sure that the com object is closed
        % before the object is cleared from memory.
            fclose(obj.com);
        end

    end % methods

end % classdef

