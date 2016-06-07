function [decimal]=Adecimal(binComp)

k=0;
T=size(binComp,2);
mod='';
if binComp(1)=='1'  
    for i=1:T
        k=k+(2^(T-i))*(str2num(binComp(i)));
    end
else
    for i=1:T
        C=binComp(i);
            if C=='0'
                z='1';
            elseif C=='1'
                z='0';
            end
        mod=strcat(mod,z);
    end
    for i=1:T
        k=k+(2^(T-i))*(str2num(mod(i)));
    end  
    k=(-1)*k;
end
decimal=k;



    