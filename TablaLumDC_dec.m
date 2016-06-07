function [SN,categoria]=TablaLumDC_dec(codigo)
Category={'0' '1' '2' '3' '4' '5' '6' '7' '8' '9' '10' '11'};
CodeLeght={'2' '3' '3' '3' '3' '3' '4' '5' '6' '7' '8' '9'};
CodeWord={'00' '010' '011' '100' '101' '110' '1110' '11110' '111110' '1111110' '11111110' '111111110'};
r=0;
k=0;
j=0;
while r~=size(CodeWord,2)
    j=j+1;
    k=strcmp(CodeWord{j},codigo);
    r=r+1;
    if k==1
        r=size(CodeWord,2);
    end
end
categoria=Category{j};
SN=k;

