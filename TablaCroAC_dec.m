function [SN,Dupla]=TablaCroAC_dec(codigo)
RunSize={'0/0' '0/1' '0/2' '0/3' '0/4' '0/5' '0/6' '0/7' '0/8' '0/9' '0/A' '1/1' '1/2' '1/3' '1/4' '1/5' '1/6' '1/7' '1/8' '1/9' '1/A' '2/1' '2/2' '2/3' '2/4' '2/5' '2/6' '2/7' '2/8' '2/9' '2/A' '3/1' '3/2' '3/3' '3/4' '3/5' '3/6' '3/7' '3/8' '3/9' '3/A' '4/1' '4/2' '4/3' '4/4' '4/5' '4/6' '4/7' '4/8' '4/9' '4/A' '5/1' '5/2' '5/3' '5/4' '5/5' '5/6' '5/7' '5/8' '5/9' '5/A' '6/1' '6/2' '6/3' '6/4' '6/5' '6/6' '6/7' '6/8' '6/9' '6/A' '7/1' '7/2' '7/3' '7/4' '7/5' '7/6' '7/7' '7/8' '7/9' '7/A' '8/1' '8/2' '8/3' '8/4' '8/5' '8/6' '8/7' '8/8' '8/9' '8/A' '9/1' '9/2' '9/3' '9/4' '9/5' '9/6' '9/7' '9/8' '9/9' '9/A' 'A/1' 'A/2' 'A/3' 'A/4' 'A/5' 'A/6' 'A/7' 'A/8' 'A/9' 'A/A' 'B/1' 'B/2' 'B/3' 'B/4' 'B/5' 'B/6' 'B/7' 'B/8' 'B/9' 'B/A' 'C/1' 'C/2' 'C/3' 'C/4' 'C/5' 'C/6' 'C/7' 'C/8' 'C/9' 'C/A' 'D/1' 'D/2' 'D/3' 'D/4' 'D/5' 'D/6' 'D/7' 'D/8' 'D/9' 'D/A' 'E/1' 'E/2' 'E/3' 'E/4' 'E/5' 'E/6' 'E/7' 'E/8' 'E/9' 'E/A' 'F/0' 'F/1' 'F/2' 'F/3' 'F/4' 'F/5' 'F/6' 'F/7' 'F/8' 'F/9' 'F/A'};
CodeLeght={'2' '2' '3' '4' '5' '5' '6' '7' '9' '10' '12' '4' '6' '8' '9' '11' '12' '16' '16' '16' '16' '5' '8' '10' '12' '15' '16' '16' '16' '16' '16' '5' '8' '10' '12' '16' '16' '16' '16' '16' '16' '6' '9' '16' '16' '16' '16' '16' '16' '16' '16' '6' '10' '16' '16' '16' '16' '16' '16' '16' '16' '7' '11' '16' '16' '16' '16' '16' '16' '16' '16' '7' '11' '16' '16' '16' '16' '16' '16' '16' '16' '8' '16' '16' '16' '16' '16' '16' '16' '16' '16' '9' '16' '16' '16' '16' '16' '16' '16' '16' '16' '9' '16' '16' '16' '16' '16' '16' '16' '16' '16' '9' '16' '16' '16' '16' '16' '16' '16' '16' '16' '9' '16' '16' '16' '16' '16' '16' '16' '16' '16' '11' '16' '16' '16' '16' '16' '16' '16' '16' '16' '14' '16' '16' '16' '16' '16' '16' '16' '16' '16' '10' '15' '16' '16' '16' '16' '16' '16' '16' '16' '16'};
CodeWord={'00' '01' '100' '1010' '11000' '11001' '111000' '1111000' '111110100' '1111110110' '111111110100' '1011' '111001' '11110110' '111110101' '11111110110' '111111110101' '1111111110001000' '1111111110001001' '1111111110001010' '1111111110001011' '11010' '11110111' '1111110111' '111111110110' '111111111000010' '1111111110001100' '1111111110001101' '1111111110001110' '1111111110001111' '1111111110010000' '11011' '11111000' '1111111000' '111111110111' '1111111110010001' '1111111110010010' '1111111110010011' '1111111110010100' '1111111110010101' '1111111110010110' '111010' '111110110' '1111111110010111' '1111111110011000' '1111111110011001' '1111111110011010' '1111111110011011' '1111111110011100' '1111111110011101' '1111111110011110' '111011' '1111111001' '1111111110011111' '1111111110100000' '1111111110100001' '1111111110100010' '1111111110100011' '1111111110100100' '1111111110100101' '1111111110100110' '1111001' '11111110111' '1111111110100111' '1111111110101000' '1111111110101001' '1111111110101010' '1111111110101011' '1111111110101100' '1111111110101101' '1111111110101110' '1111010' '11111111000' '1111111110101111' '1111111110110000' '1111111110110001' '1111111110110010' '1111111110110011' '1111111110110100' '1111111110110101' '1111111110110110' '11111001' '1111111110110111' '1111111110111000' '1111111110111001' '1111111110111010' '1111111110111011' '1111111110111100' '1111111110111101' '1111111110111110' '1111111110111111' '111110111' '1111111111000000' '1111111111000001' '1111111111000010' '1111111111000011' '1111111111000100' '1111111111000101' '1111111111000110' '1111111111000111' '1111111111001000' '111111000' '1111111111001001' '1111111111001010' '1111111111001011' '1111111111001100' '1111111111001101' '1111111111001110' '1111111111001111' '1111111111010000' '1111111111010001' '111111001' '1111111111010010' '1111111111010011' '1111111111010100' '1111111111010101' '1111111111010110' '1111111111010111' '1111111111011000' '1111111111011001' '1111111111011010' '111111010' '1111111111011011' '1111111111011100' '1111111111011101' '1111111111011110' '1111111111011111' '1111111111100000' '1111111111100001' '1111111111100010' '1111111111100011' '11111111001' '1111111111100100' '1111111111100101' '1111111111100110' '1111111111100111' '1111111111101000' '1111111111101001' '1111111111101010' '1111111111101011' '1111111111101100' '11111111100000' '1111111111101101' '1111111111101110' '1111111111101111' '1111111111110000' '1111111111110001' '1111111111110010' '1111111111110011' '1111111111110100' '1111111111110101' '1111111010' '111111111000011' '1111111111110110' '1111111111110111' '1111111111111000' '1111111111111001' '1111111111111010' '1111111111111011' '1111111111111100' '1111111111111101' '1111111111111110'};
r=0;
k=0;
j=0;
while r~=size(RunSize,2)
    j=j+1;
    k=strcmp(CodeWord{j},codigo);
    r=r+1;
    if k==1
        r=size(RunSize,2);
    end
end

SN=k;
Dupla=RunSize{j};


