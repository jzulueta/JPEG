clear all
close all
X=50; %Calidad deseada
Vecbloque{4800}=[];
Vecbloque_Cb{1200}=[];
Vecbloque_Cr{1200}=[];
vector_reconst{4800}=[];
NivelDC=(-128*ones(8,8));
Codigo_entropico='';
Codigo_entropico_Cb='';
Codigo_entropico_Cr='';
Dato_AC='';
Dato_DC='';

C1=(100-X)/50;  % Si X>50 multiplicar por Q
C2=(50/X);      % Si X<50 multiplicar por Q

%matrices de calidad l para luminancia c para croma
Ql50=[16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55; 14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62; 18 22 37 56 68 109 103 77;24 36 55 64 81 104 113 92; 49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 99]; 
Qc50=[17 18 24 47 99 99 99 99; 18 21 26 66 99 99 99 99; 24 26 56 99 99 99 99 99; 47 66 99 99 99 99 99 99; 99 99 99 99 99 99 99 99;99 99 99 99 99 99 99 99; 99 99 99 99 99 99 99 99; 99 99 99 99 99 99 99 99;];

% Obtenemos la imagen del directorio y lo asignamos a una variable
Img_original=imread('prueba1.jpg');
% Cambiamos la imagen de RGB a Y Cr Cb
Img_YCbCr=rgb2ycbcr(Img_original);


%Separamos las componentes de croma y luma de la señal
Img_grises=Img_YCbCr(:,:,1); %Y
Img_Cb=Img_YCbCr(:,:,2); %Cb
Img_Cr=Img_YCbCr(:,:,3); %Cr


%Submuestreamos la crominancia
k=1;
l=1;
for n=1:2:480
    for m=1:2:640
        promedio_Cb=mean(mean(Img_Cb(n:n+1,m:m+1)));  %como son matrices de 2x2 calulamos el promedio del promedio para obtener un solo valor
        promedio_Cr=mean(mean(Img_Cr(n:n+1,m:m+1)));
        Img_Cb_final(k,l)=promedio_Cb;
        Img_Cr_final(k,l)=promedio_Cr;
        l=l+1;
    end
    l=1;
    k=k+1;
end


%separando la imagen de luminancia en bloques 8x8
k=1;
l=1; 
for n=1:8:480
    for m=1:8:640
        bloque{k,l}=double(Img_grises(n:n+7,m:m+7));
        l=l+1;
    end
    l=1;
    k=k+1;
end

%separando la imagen de Croma en bloques 8x8
k=1;
l=1; 
for n=1:8:240
    for m=1:8:320
        bloque_Cb{k,l}=Img_Cb_final(n:n+7,m:m+7);
        bloque_Cr{k,l}=Img_Cr_final(n:n+7,m:m+7);
        l=l+1;
    end
    l=1;
    k=k+1;
end


for i=1:60
    for j=1:80
        bloque{i,j}=bloque{i,j}+NivelDC; %restando 128
        DCTbloque{i,j}=dct2(bloque{i,j}); %aplicando la transformada directa del coseno
        CTbloque{i,j}=round(DCTbloque{i,j}./Ql50); %cuantizando bloque a bloque
    end
end

for i=1:30
    for j=1:40
        bloque_Cb{i,j}=bloque_Cb{i,j}+NivelDC; %restando 128
        bloque_Cr{i,j}=bloque_Cr{i,j}+NivelDC;
        DCTbloque_Cb{i,j}=dct2(bloque_Cb{i,j}); %aplicando la transformada directa del coseno
        DCTbloque_Cr{i,j}=dct2(bloque_Cr{i,j});
        CTbloque_Cb{i,j}=round(DCTbloque_Cb{i,j}./Qc50);%cuantizando bloque a bloque
        CTbloque_Cr{i,j}=round(DCTbloque_Cr{i,j}./Qc50);
    end
end

%Lectura en zig zag de cada bloque de luminancia
%Se observo el orden de los subindices de la matriz 8x8 y se separo en 14
%bloques que seguian un patron; k indice del bloque ; M subindice mas
%pequeño dentro del bloque k; N subindice mas grande dentro del bloque k;
%l elemento del vector resultante
l=1;
for i=1:60
    for j=1:80
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
                    Vecbloque{l}=[Vecbloque{l} CTbloque{i,j}(n,x)];
                    n=n-1;
                end
            else
                n=N;
                for y=M:N
                    Vecbloque{l}=[Vecbloque{l} CTbloque{i,j}(y,n)];
                    n=n-1;
                end
            end
         k=k+1;
        end
        l=l+1;
    end
end

%Lectura en zigzag de los bloques 8x8 de crominancia, sigue el mismo patron
%del anterior
l=1;
z=0;
for i=1:30
    for j=1:40
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
                    Vecbloque_Cb{l}=[Vecbloque_Cb{l} CTbloque_Cb{i,j}(n,x)];
                    Vecbloque_Cr{l}=[Vecbloque_Cr{l} CTbloque_Cr{i,j}(n,x)];
                    n=n-1;
                end
            else
                n=N;
                for y=M:N
                    Vecbloque_Cb{l}=[Vecbloque_Cb{l} CTbloque_Cb{i,j}(y,n)];
                    Vecbloque_Cr{l}=[Vecbloque_Cr{l} CTbloque_Cr{i,j}(y,n)];
                    n=n-1;
                end
            end
         k=k+1;
        end
        l=l+1;
        z=z+1;
    end
end

%generando las componentes diferenciales DC de la luminancia
%restando el actual menos el siguiente, el ultimo no cambiara por lo que la
%iteracion solo llega a 4799
for i=1:4799
    Vecbloque{i}(1)=Vecbloque{i+1}(1)-Vecbloque{i}(1);
end

%generando las componentes diferenciales DC de la crominancia, mismo patron

for i=1:1199
    Vecbloque_Cb{i}(1)=Vecbloque_Cb{i+1}(1)-Vecbloque_Cb{i}(1);
    Vecbloque_Cr{i}(1)=Vecbloque_Cr{i+1}(1)-Vecbloque_Cr{i}(1);
end

%Codificacion entropica
%luminancia
for i=1:4800
strDC=CodLumDC(Vecbloque{i}(1)); %dandole el elemento DC del vector, retorna una cadena de caracteres con el codigo binario del dato
strAC=CodLumAC(Vecbloque{i}); % dandole un vector de 64 elementos codifica las 63 componentes AC y devuelve la cadena de caracteres correspondiente
Codigo_entropico=strcat(Codigo_entropico,strDC,strAC); %concatena los codigos DC y AC con el codigo ya calculado previamente
end
%crominancia, igual que el anterior pero genera 2 codigos, los de Cr y Cb
for i=1:1200
strCroDC=CodCroDC(Vecbloque_Cb{i}(1));
strCroAC=CodCroAC(Vecbloque_Cb{i});
Codigo_entropico_Cb=strcat(Codigo_entropico_Cb,strCroDC,strCroAC);
strCroDC=CodCroDC(Vecbloque_Cr{i}(1));
strCroAC=CodCroAC(Vecbloque_Cr{i});
Codigo_entropico_Cr=strcat(Codigo_entropico_Cr,strCroDC,strCroAC);
end

%Guardamos los codigos calculados

Codigo_Y=Codigo_entropico;
Codigo_Cb=Codigo_entropico_Cb;
Codigo_Cr=Codigo_entropico_Cr;

%Decodificación de la luminancia
for t=1:4800
[Inicio,Codigo_entropico]=Decod_DC(Codigo_entropico); %dado el codigo, retorna el elemento DC del vector
vector_reconst{t}(1)=Inicio;
M=2;
    while M<=64
        %Dado el codigo, retorna el numero de ceros antes del valor AC, el
        %numero de bits requerido para expresar ese valor y el codigo que sobra
        [NumCeros,bits,Codigo_entropico]=Decod_AC(Codigo_entropico);
        [M,Codigo_entropico,vector_reconst]=Coef_AC(NumCeros,bits,vector_reconst,Codigo_entropico,M,t); 
        %Dadas las salidas de Decod_AC y el vector donde colocar el
        %coeficiente, el numero de vector t y el elemento M dentro de ese
        %vector donde colocar el coeficiente AC retorna el codigo sobrante,
        %el vector nuevo, y la posicion del vector donde va a escribir
        %despues
    end
end

%Decodificacion de la Crominancia

for t=1:1200
[Inicio,Codigo_entropico_Cb]=DecodCro_DC(Codigo_entropico_Cb);
vector_reconst_Cb{t}(1)=Inicio;
[Inicio,Codigo_entropico_Cr]=DecodCro_DC(Codigo_entropico_Cr);
vector_reconst_Cr{t}(1)=Inicio;
M=2;
    while M<=64
        [NumCeros,bits,Codigo_entropico_Cb]=DecodCro_AC(Codigo_entropico_Cb);
        [M,Codigo_entropico_Cb,vector_reconst_Cb]=CoefCro_AC(NumCeros,bits,vector_reconst_Cb,Codigo_entropico_Cb,M,t);  
    end
    M=2;
    while M<=64
        [NumCeros,bits,Codigo_entropico_Cr]=DecodCro_AC(Codigo_entropico_Cr);
        [M,Codigo_entropico_Cr,vector_reconst_Cr]=CoefCro_AC(NumCeros,bits,vector_reconst_Cr,Codigo_entropico_Cr,M,t);
    end
end


%Escritura en zig-zag%devolvenmos los coeficientes DC a su forma natural.
n=4800;
for i=1:n-1
    vector_reconst{n-i}(1)=vector_reconst{n-i+1}(1)-vector_reconst{n-i}(1);
end

m=1200;
for i=1:m-1
    vector_reconst_Cb{m-i}(1)=vector_reconst_Cb{m-i+1}(1)-vector_reconst_Cb{m-i}(1);
    vector_reconst_Cr{m-i}(1)=vector_reconst_Cr{m-i+1}(1)-vector_reconst_Cr{m-i}(1);
end

%Escribimos los bloques 8x8 en base a los vectores siguiendo el patron de
%zig-zag
Bloque_reconst_Y=Escr_ZZ(vector_reconst,60,80); %Dado el numero de colummnas y filas a generar y el vector decodificado, obtenemos una celda de bloques 8x8
Bloque_reconst_Cb=Escr_ZZ(vector_reconst_Cb,30,40);
Bloque_reconst_Cr=Escr_ZZ(vector_reconst_Cr,30,40);

%aplicammos las operaciones inversas aplicadas al inicio del programa
for i=1:30
    for j=1:40
        CTBloque_reconst_Cb{i,j}=Bloque_reconst_Cb{i,j}.*Qc50;
        CTBloque_reconst_Cr{i,j}=Bloque_reconst_Cr{i,j}.*Qc50;
        ICTBloque_reconst_Cb{i,j}=idct2(CTBloque_reconst_Cb{i,j}); %aplicando la transformada inversa del coseno
        ICTBloque_reconst_Cr{i,j}=idct2(CTBloque_reconst_Cr{i,j});
        Bloque_final_Cb{i,j}=ICTBloque_reconst_Cb{i,j}-NivelDC; %Sumando 128
        Bloque_final_Cr{i,j}=ICTBloque_reconst_Cr{i,j}-NivelDC;
    end
end

for i=1:60
    for j=1:80 
        CTBloque_reconst_Y{i,j}=Bloque_reconst_Y{i,j}.*Ql50;
        ICTBloque_reconst_Y{i,j}=idct2(CTBloque_reconst_Y{i,j});
        Bloque_final_Y{i,j}=ICTBloque_reconst_Y{i,j}-NivelDC;
    end
end

%Reconstruccion de la imagen


Img_Y_final=[];
for i=1:60
    Img_parcial=[];
    for j=1:80
    D=Bloque_final_Y{i,j};
    Img_parcial=[Img_parcial D];
    end
    Img_Y_final=[Img_Y_final; Img_parcial];
end

Img_Cb_sub=[];
Img_Cr_sub=[];
for i=1:30
    Img_Cb_parcial=[];
    Img_Cr_parcial=[];
    for j=1:40
    D_Cb=Bloque_final_Cb{i,j};
    D_Cr=Bloque_final_Cr{i,j};
    Img_Cb_parcial=[Img_Cb_parcial D_Cb];
    Img_Cr_parcial=[Img_Cr_parcial D_Cr];
    end
    Img_Cb_sub=[Img_Cb_sub; Img_Cb_parcial];
    Img_Cr_sub=[Img_Cr_sub; Img_Cr_parcial];    
end

%Replicamos los valores de crominancia x4 de modo de volver a obtener una
%matriz 480x640, deshacemos el submuestreo

l=1;
for m=1:2:480
    k=1;
    for n=1:2:640
        Img_Cb_final1(m:m+1,n:n+1)=Img_Cb_sub(l,k);
        Img_Cr_final1(m:m+1,n:n+1)=Img_Cr_sub(l,k);
        k=k+1;
    end
    l=l+1;
end

%Asignamos a una variable 3 campos, Y Cb Cr 
IMG_RECUP(:,:,1)=uint8(Img_Y_final); 
IMG_RECUP(:,:,2)=uint8(Img_Cb_final1);
IMG_RECUP(:,:,3)=uint8(Img_Cr_final1);

%La llevamos al campo RGB
Img_RGB=ycbcr2rgb(IMG_RECUP);
imshow([Img_grises Img_Cb Img_Cr;IMG_RECUP(:,:,1) IMG_RECUP(:,:,2) IMG_RECUP(:,:,3)]) %luminancia y Crominancia orginal en la primera fila, luminancia y crominancia decodificada
figure
imshow([Img_YCbCr IMG_RECUP;Img_original Img_RGB]) % imagen original y decodificada en YCbCr en la primera fila, Imagen original y decodificada en la segunda
