function vo = voltageDivider(start, stop, numData, filename)
    fgen = Fgen();
    osc = Osc();

    %incrVal = (stop - start)/numData;
    %endVal = stop-incrVal;
    %vo = [start : incrVal : endVal];
    %vin = [start : incrVal : endVal];
    i = 1;

    volt = linspace(stop, start, numData);
    
    for voltage = volt
        fgen.setVoltAmplitude(voltage);
        if i == 1
            osc.autoSet();
            pause(2.0)
        end
        vin(i) = fgen.getVoltAmplitude()*2;
        pause(.5); % one second
        vo(i) = osc.getPk2PkCH2();
        i = i + 1;
    end
    
    plot(vin, vo)
    title('Vout vs Vin')
    xlabel('Vin')
    ylabel('Vout')   
 
    header = {'Vout','Vin'};
    retVal = {'Vout', 'Vin'; vo, vin} ;
    xlswrite(filename, header, 1, '1')
    xlswrite(filename, vo.', 1,'A2')
    xlswrite(filename, vin.', 1,'B2')
    
    clear fgen
    clear osc
end
