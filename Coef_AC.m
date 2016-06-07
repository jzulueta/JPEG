            
function [M,Cod_resultante,Vector,dato]=Coef_AC(NumCeros,Bitsreq,vector_reconst,Codigo_entropico,m,t)
            Dato_AC='';
            if NumCeros==0
                if Bitsreq==0
                    for e=m:64
                        vector_reconst{t}(e)=0;
                        m=65;
                    end
                    Dato_AC='EOB';
                else
                    for w=1:Bitsreq
                        Dato_AC=strcat(Dato_AC,Codigo_entropico(w));
                    end
                    Codigo_entropico=Codigo_entropico(Bitsreq+1:size(Codigo_entropico,2));
                    vector_reconst{t}(m)=Adecimal(Dato_AC);
                    m=m+1;
                end
            else
                if Bitsreq==0
                    for q=m:m+15
                        vector_reconst{t}(q)=0;
                    end
                    m=m+16;
                else
                    for x=m:m+NumCeros-1
                        vector_reconst{t}(x)=0;
                    end
                    m=m+NumCeros;
                    for q=1:Bitsreq
                        Dato_AC=strcat(Dato_AC,Codigo_entropico(q));
                    end
                    Codigo_entropico=Codigo_entropico(Bitsreq+1:size(Codigo_entropico,2));
                    vector_reconst{t}(m)=Adecimal(Dato_AC);
                    m=m+1;
                end
            end
            
            Cod_resultante=Codigo_entropico;
            Vector=vector_reconst;
            M=m;
            dato=Dato_AC;