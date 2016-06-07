function [Bloque]=Escr_ZZ(Vector,T,R)
l=1;
f=1;
for i=1:T
    for j=1:R
        f=1;
        k=0;
        M=1;
        while k<=14,
            switch k
                case 0,
                    Dir=1;N=1;
                case 1,
                    Dir=0;N=2;
                case 2,
                    Dir=1;N=3;
                case 3,
                    Dir=0;N=4;
                case 4,
                    Dir=1;N=5;
                case 5,
                    Dir=0;N=6;
                case 6,
                    Dir=1;N=7;
                case 7,
                    Dir=0;N=8;
                case 8,
                    Dir=1;M=2;
                case 9,
                    Dir=0;M=3;
                case 10,
                    Dir=1;M=4;
                case 11,
                    Dir=0;M=5;
                case 12,
                    Dir=1;M=6;
                case 13,
                    Dir=0;M=7;
                case 14,
                    Dir=1;M=8;
            end
          
            if Dir==1
                n=N;
                for x=M:N
                    Bloque{i,j}(n,x)=Vector{l}(f);
                    f=f+1;
                    n=n-1;
                end
            else
                n=N;
                for y=M:N
                    Bloque{i,j}(y,n)=Vector{l}(f);
                    f=f+1;
                    n=n-1;
                end
            end
         k=k+1;
        end
        l=l+1;
    end
end