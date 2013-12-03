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
        %channels = -1;
        scaleCH1 = -1;
        scaleCH2 = -1;
        baudRate = -1;
        %data;
        
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

            osc.checkConnected();

            %osc.channels = osc.getChannels();
            osc.scaleCH1 = osc.getScaleCH1();
            osc.scaleCH2 = osc.getScaleCH2();
            osc.baudRate = osc.com.BaudRate;

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
            obj.com.TimeOut = 1;
            fopen(obj.com);
            fprintf(obj.com, '*IDN?');
            res = fscanf(obj.com);
            if strfind(res, 'TEKTRONIX')
                display('SUCCESS: Oscilloscope connected properly!')
            else
                display('ERROR: Oscilloscope not connected properly!')
            end
            fclose(obj.com);
            obj.com.TimeOut = 10;
        end

        function autoSet(obj)
        % Description: Ensures that the actual Oscilloscope is connected.
        % Result: Tells the user that the Oscilloscope is connected.
            fopen(obj.com);
            cmd = ['AUTOSet EXECute '];
            fprintf(obj.com, cmd);
            fclose(obj.com);
        end

        function retVal = dumpData(obj, filename)
        % Description: Possible use in the future to store data to an osc obj
        %    and dump that data to an excel spreadsheet.
        %    Also possible would be a wrapper around the xlswrite function as
        %    the function is not very intuitive to use
        % Input Args: filename(str)
        % Example:
        %    osc.dumpData('data')
            disp('Function: dumpData not implemented yet. Please Implement.')
            retVal = filename;
        end

        function retVal = dumpScreenshot(obj, filename)
        % Description: Undecided on whether the best method would be to get
        %     the screenshot directly or build the screenshot out of data
        % Input Args: filename(str)
        % Example:
        %    osc.dumpScreenShot('screenshot.png')
            disp('Function: dumpScreenshot not implemented yet. Please Implement.')
            retVal = filename;
        end

        function retVal = getVoltageTrigger(obj)
        % Description: Get the trigger holdoff value
        % Example:
        %    osc.getVoltageTrigger()
            fopen(obj.com);
            cmd = ['DISplay:FORMat { XY | YT } '];
            fprintf(obj.com, cmd);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
        end

        function retVal = getChannels(obj)
        % Description: Test to see what channels are available
        % Example:
            fopen(obj.com);
            cmd = ['CH1? '];
            cmd2 = ['CH2? '];
            fprintf(obj.com, cmd);
            retVal = fscanf(obj.com);
            fprintf(obj.com, cmd2);
            retVal = [retVal fscanf(obj.com);]
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
        
        function retVal = getFrequencyCH1(obj)
        % Description: Gets the vertical or horizontal cursor settings
        % Example:
            fopen(obj.com);
            cmd = [':MEASUREMENT:IMMED:TYPE FREQUENCY;SOURCE CH1; '];
            cmd2 = ['MEASUREMENT:IMMED:VALUE? '];
            fprintf(obj.com, cmd);
            fprintf(obj.com, cmd2);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
        end
        
        function retVal = getFrequencyCH2(obj)
        % Description: Gets the vertical or horizontal cursor settings
        % Example:
            fopen(obj.com);
            cmd = [':MEASUREMENT:IMMED:TYPE FREQUENCY;SOURCE CH2; '];
            cmd2 = ['MEASUREMENT:IMMED:VALUE? '];
            fprintf(obj.com, cmd);
            fprintf(obj.com, cmd2);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
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
        
        function retVal = getPlotCH2(obj)
        % Example:
            fopen(obj.com);
            fprintf(obj.com, 'Data:Source CH2');
            fprintf(obj.com, 'Data:Encdg SRIbinary');
            fprintf(obj.com, 'Data:Width 2');
            fprintf(obj.com, 'Data:Start 1');
            fprintf(obj.com, 'Data:Stop 2500');
            fprintf(obj.com, 'Curve? ');
            retVal = fread(obj.com, 2500, 'int16');
            cleanup = fscanf(obj.com);
            
            fprintf(obj.com, 'wfmpre:ch2:xincr?')
            horzmult2 = str2num(fscanf(obj.com));
            
            xch = horzmult2.*linspace(1,2500,2500);
            retVal = obj.scaleCH2.*retVal;
            
            plot(xch2,retVal)
            
            fclose(obj.com)
        end

        function retVal = getPlotCH1(obj)
        % Example:
            fopen(obj.com);
            fprintf(obj.com, 'Data:Source CH1');
            fprintf(obj.com, 'Data:Encdg SRIbinary');
            fprintf(obj.com, 'Data:Width 2');
            fprintf(obj.com, 'Data:Start 1');
            fprintf(obj.com, 'Data:Stop 2500');
            fprintf(obj.com, 'Curve? ');
            retVal = fread(obj.com, 2500, 'int16');
            cleanup = fscanf(obj.com);
            
            fprintf(obj.com, 'wfmpre:ch2:xincr?')
            horzmult = str2num(fscanf(obj.com));
            
            xch = horzmult.*linspace(1,2500,2500);
            retVal = obj.scaleCH1.*retVal;
            
            plot(xch2,retVal)
            
            fclose(obj.com)
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

        function retVal = getPk2PkCH1(obj)
        % Description: Measures the Pk2Pk Voltage off of CH1
        % Input Args: none
        % Return Value: retVal(float)
        % Example:
        %    osc.getPk2PkCH1()
            fopen(obj.com);
            cmd = [':MEASUREMENT:IMMED:TYPE PK2PK;SOURCE CH1; '];
            cmd2 = ['MEASUREMENT:IMMED:VALUE? '];
            fprintf(obj.com, cmd);
            fprintf(obj.com, cmd2);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
            
            scale = obj.getScaleCH1();
            if scale > retVal
                obj.setScaleCH1(scale/4)
                retVal = obj.getPk2PkCH1()
            end
            %if scale * 8 < retVal
            %end
        end

        function retVal = getPk2PkCH2(obj)
        % Description: Measures the Pk2Pk Voltage off of CH2
        % Input Args: none
        % Return Value: retVal(float)
        % Example:
        %    osc.getPk2PkCH2()
            fopen(obj.com);
            cmd = [':MEASUREMENT:IMMED:TYPE PK2PK;SOURCE CH2; '];
            cmd2 = ['MEASUREMENT:IMMED:VALUE? '];
            fprintf(obj.com, cmd);
            fprintf(obj.com, cmd2);
            retVal = str2num(fscanf(obj.com));
            fclose(obj.com);
            
            scale = obj.getScaleCH2();
            if scale > retVal
                obj.setScaleCH2(scale/4);
                retVal = obj.getPk2PkCH2();
            end
            %if scale * 8 < retVal
            
            %end
        end
        
        function setScaleCH1(obj, scale)
        % Description: Sets the vertical scale of the oscilloscope for CH1
        % Input Args: scale(float)
        % Example:
        %    osc.setScaleCH1(0.27)
            fopen(obj.com);
            cmd = 'CH1:SCAle ';
            cmd = [cmd num2str(scale)];
            fprintf(obj.com, cmd);
            fclose(obj.com);
        end
        
        function setScaleCH2(obj, scale)
        % Description: Sets the vertical scale of the oscilloscope for CH2
        % Input Args: scale(float)
        % Example:
        %    osc.setScaleCH1(0.27)
            fopen(obj.com);
            cmd = 'CH2:SCAle ';
            cmd = [cmd num2str(scale)];
            fprintf(obj.com, cmd);
            fclose(obj.com);
        end           
        
    end % methods

end % classdef
