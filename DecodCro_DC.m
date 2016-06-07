function [Valor_DC,Cod_ent_nuevo]=DecodCro_DC(Codigo_entropico)

Dato_DC='';
n=0; 
s=2;
NumBits=0;
while n==0
        Cod_DC=Codigo_entropico(1:s);
        [l,CAT]=TablaCroDC_dec(Cod_DC);
        if l==0
            s=s+1;
        else
            if CAT=='0';
                Inicio=0;
                Codigo_entropico=Codigo_entropico(s+NumBits+1:size(Codigo_entropico,2));
                n=1;
            else
                NumBits=str2num(CAT);
                for k=(s+1):s+NumBits
                    Dato_DC=strcat(Dato_DC,Codigo_entropico(k));
                end
                Codigo_entropico=Codigo_entropico(s+NumBits+1:size(Codigo_entropico,2));
                Inicio=Adecimal(Dato_DC);
                n=1;
            end
        end
end

Cod_ent_nuevo=Codigo_entropico;
Valor_DC=Inicio;
