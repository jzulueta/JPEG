function [CodAC]=CodLumAC(BloqueVec)
CodAC='';
i=1;
j=0;
l=0;
while i<size(BloqueVec,2)
    y=0;
    i=i+1;
    C=BloqueVec(i);
    if C==0
        j=j+1;
        if j==16
        dupla=strcat('F','/','0');
        CodDupla=TablaLumAC(dupla);
        Cod_pos_fin=CodDupla;
        l=l+1;
        j=0;
        end            
    else
        if l~=0
            for m=1:l
            CodAC=strcat(CodAC,Cod_pos_fin);
            end
            l=0;
        end
        numceros=dec2hex(j);
        numbit=num2str(size(dec2bin(abs(BloqueVec(i))),2));
        CodPal=CompA1(BloqueVec(i));
        dupla=strcat(numceros,'/',numbit);
        CodDupla=TablaLumAC(dupla);
        CodAC=strcat(CodAC,CodDupla,CodPal);
        y=1;
        j=0;
    end
end

if y==0
    CodAC=strcat(CodAC,'1010');
end

