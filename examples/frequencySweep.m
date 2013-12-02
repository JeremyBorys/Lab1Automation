
function retVal = frequencySweep(arrFreq)
    % Description: Completes a frequency sweep across an array with
    % specified frequencies
    % Example: 
    %   array = [1000,2000,3000,5000]
    %   frequencySweep(array)
    fgen = Fgen();
    osc = Osc();
    i = 1;
    ii = 1;
    vo = [];
    vin = [];
    freq = [];
    gain = [];
    for elem = arrFreq
        fgen.setFrequency(elem);
        if i == 1
            osc.autoSet()
            pause(0.5)
        end
        if ii == 6
            osc.autoSet()
            ii = 1;
        end
        vo_data = osc.getPk2PkCH1(); 
        vi_data = osc.getPk2PkCH2();
        vin = [vin vi_data];
        vo = [vo vo_data];
        
        gain = [gain vi_data/vo_data];

        freq = [freq osc.getFrequencyCH1()];
        pause (.5);
        i = i+1;
        ii = ii+1;
    end
    
    prompt = 'Enter the file name: ';
    filename = input(prompt,'s');
    %filename = [filename, '.xlsx'];
    filename = strcat(filename, '.xlsx');
    semilogx(freq, gain)
    title('Vout vs Vin')
    xlabel('Vin')
    ylabel('Vout')

 
    header = {'Frequency','Vout','Vin','Gain'};
    retVal = {'Frequency', 'Vout', 'Vin', 'Gain'; freq, vo, vin, gain} ;
    xlswrite(filename, header, 1, '1')
    xlswrite(filename, freq.', 1,'A2')
    xlswrite(filename, vo.', 1,'B2')
    xlswrite(filename, vin.', 1,'C2')
    xlswrite(filename, gain.', 1,'D2')

    clear fgen
    clear osc
end
