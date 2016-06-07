function [Valor]=CompA1(elemDC)

binDC=dec2bin(abs(elemDC));

if elemDC<0
s=size((dec2bin(abs(elemDC))),2);
Valor='';
    for i=1:s
        C=binDC(i);
            if C=='0'
                z='1';
            elseif C=='1'
                z='0';
            end
        Valor=strcat(Valor,z);
    end
elseif elemDC>=0
    Valor=dec2bin(abs(elemDC));
end