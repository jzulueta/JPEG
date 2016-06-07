function [numerohex]=str2hex(caracter)

k=caracter;
switch k
    case '0',
        numerohex=0;
    case '1',
        numerohex=1;
    case '2',
        numerohex=2;
    case '3',
        numerohex=3;
    case '4',
        numerohex=4;
    case '5'
        numerohex=5;
    case '6',
        numerohex=6;
    case '7',
        numerohex=7;
    case '8',
        numerohex=8;
    case '9',
        numerohex=9;
    case 'A',
        numerohex=10;
    case 'B',
        numerohex=11;
    case 'C',
        numerohex=12;
    case 'D',
        numerohex=13;
    case 'E',
        numerohex=14;
    case 'F',
        numerohex=15;
end
