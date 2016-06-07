function [PalabraCod]=TablaLumDC(categoria)
Category={'0' '1' '2' '3' '4' '5' '6' '7' '8' '9' '10' '11'};
CodeLeght={'2' '3' '3' '3' '3' '3' '4' '5' '6' '7' '8' '9'};
CodeWord={'00' '010' '011' '100' '101' '110' '1110' '11110' '111110' '1111110' '11111110' '111111110'};
k=0;
i=0;
while k~=1
    i=i+1;
    k=strcmp(Category{i},categoria);
end
PalabraCod=CodeWord{i};



