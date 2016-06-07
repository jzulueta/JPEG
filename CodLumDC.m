function [codigo]=CodLumDC(Elemento_DC)
codigo='';
if Elemento_DC~=0
    Categoria=num2str(size(dec2bin(abs(Elemento_DC)),2));
    SSS=TablaLumDC(Categoria);
    VALOR=CompA1(Elemento_DC);
    codigo=strcat(SSS,VALOR);
else
    codigo=TablaLumDC('0');
end



