%Description:
%   The Osc class allows for control of the Tektronix TDS1012 Oscilloscope inside of
%   SFU's Ensc Lab1.
%Examples:
%   To use you must first instantiate an Osc object:
%   osc = Osc()
%   After the osc object is instantiated you now have access to all of the objects internal methods
%   osc.getVoltage()
%   osc.getChannels()
%   osc.getScale()
%   osc.dumpData(filename)
%   osc.dumpScreenshot(filename)
%Authors:
%   Lester Chee, Ryley Morgan, Jacky Jiang, Yao Li, Joshua Kong, Richard Xie
classdef Osc
    properties
        channels = -1;
        scale = -1;
        baudRate = -1;
        data;
    end

    %private properties are only accessible by calling getter and setters
    properties(access=private)
        com = -1;
    end

    methods

        % Description: Constructor method that is called upon instantiation/creation
        % Sets the initial parameters of the function generator
        function osc = Osc()

            % initialize the com object to talk to. Currently we are assuming that the osc is
            % connected to COM port 1
            osc.com = serial ('COM2');

            osc.testBaudRate();
            osc.checkConnected();

            osc.channels = osc.getChannels();
            osc.scale = osc.getScale();
            osc.baudRate = osc.com.BaudRate;

        end

        % Description: Ensures that the actual function Generator is connected
        % Result: Tells the user that the BaudRate for the device is not set correctly
        function checkConnected(obj)
            disp('Function: checkConnected not implemented yet. Please Implement.')
        end

        % Description: Ensures that the baudrate is correct
        % Result: Tells the user that the BaudRate for the device is not set correctly
        function testBaudRate(obj)
            disp('Function: testBaudRate not implemented yet. Please Implement.')
        end

        % Description:
        % Input Args:
        % Example:
        function retVal = dumpData(obj, filename)
            disp('Function: checkConnected not implemented yet. Please Implement.')
            retVal = filename;
        end

        % Description:
        % Input Args:
        % Example:
        function retVal = dumpScreenshot(obj, filename)
            disp('Function: checkConnected not implemented yet. Please Implement.')
            retVal = filename;
        end

        % Description:
        % Example:
        function retVal = getVoltage(obj)
            disp('Function: checkConnected not implemented yet. Please Implement.')
            retVal = -1;
        end

        % Description:
        % Example:
        fucntion retVal = getChannels(obj)
            disp('Function: checkConnected not implemented yet. Please Implement.')
            retVal = -1;
        end

        % Description:
        % Example:
        function retVal = getScale(obj)
            disp('Function: checkConnected not implemented yet. Please Implement.')
            retVal = -1;
        end
        
        % Description: Provides an interface for the user to access the com object
        % Example: 
        %   osc = Osc();
        %   osc.getCom
        function com = getCom(obj)
            com = obj.com
        end
        
        % Description:
        % Input Args:
        % Example:
        function setScale(obj, inargs)
            disp('Function: checkConnected not implemented yet. Please Implement.')
        end

        % Description: delete(obj) is the destructor method for the osc obj. the methoed is called
        % every time the object is 'cleared'. We want to make sure that the com object is closed
        % before the object is cleared from memory.
        function delete(obj)
            fclose(obj.com);
        end

    end % methods

end % classdef

