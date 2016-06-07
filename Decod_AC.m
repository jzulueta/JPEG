function [Num_Ceros,Bits_req,Cod_Nuevo]=Decod_AC(Codigo_entropico)
NumCeros=0;
Bitsreq=0;
m=2;
l=0;
j=2;
while l==0;
    Cod_AC=Codigo_entropico(1:j);
    [l,Dupla]=TablaLumAC_dec(Cod_AC);
        if l==0
            j=j+1;
        else
            NumCeros=str2hex(Dupla(1));
            Bitsreq=str2hex(Dupla(3));
            Codigo_entropico=Codigo_entropico(j+1:size(Codigo_entropico,2));
            l=1;
        end
end
Num_Ceros=NumCeros;
Bits_req=Bitsreq;
Cod_Nuevo=Codigo_entropico;