function Output=rle(Input)   %%%%%Function 1
L=length(Input);
j=1;
k=1;
i=1;
while i<2*L
    comp=1;
    for j=j:L
        if j==L 
            break
        end;  
         if Input(j)==Input(j+1)
            comp=comp+1;
        else
            break
        end;
    end;
        Output(k+1)=comp;
        Output(k)=Input(j);
        if j==L && Input(j-1)==Input(j) 
            break
        end;  
        i=i+1;
        k=k+2;
        j=j+1;
        if j==L 
            if mod(L,2)==0 
              Output(k+1)=1;
              Output(k)=Input(j);
            else
              Output(k+1)=1;    
              Output(k)=Input(j);
            end;
             break
        end;
end
% Function of RLE (Run Length Encoding) was used on program of gray level image compression .
% Authors : Said Bourezg  - Derbel Abd Elhak
% Electronics Engineer  option:communication .
% Date : 05.26.2009
% Filename rle.m (Matlab)
% This function is part of my undergraduate project in M'sila university, Algeria.
% Adress:                          Said BOUREZG
%                               Elbassatine street
%                                 28038 Tarmount
%                               M'sila --- Algeria 
% Email:  said.bourezg@yahoo.fr
% Mobile: +213 796 018049 
% If you can improve this code furtherly, please let me know. Thanks





%  function e = rle(x) %Entering input string for run length encoding %%%%%Function 2 ?????? ????
% %Pankaj Joshi India 
% % encode input matrix according to runlength encoding
% %e=run_length(x) where x is input matrix and e is encoded version of x
% %if input is a cractor string then return a run length encoded stream
% %with ASCII CODE WITH ITS RESPECTIVE RUNS.
% % by run length encoding
% %example1 
% % x=[1,1,1,1,1,1,0,0,0,0];
% %y=run_length(x);
% %y= 6 1 4 0
% %example2
% %x=[1,1,1,1,1,1,0,0,0,0;1,1,1,1,1,1,0,0,0,0];
% %y=run_length(x)
% %y=
% %6 1 4 0
% %6 1 4 0
% %example3
% %encoding of image file
% %x=im2bw('Image_name')
% %y=run_length(x)
% %encoding
% %first step count number of changes ouccers in bit stream
% c=size(x);
% if c(1)==1
%     n=0;
% for i=1:length(x)-1
%     if x(i)~=x(i+1);
%         n=n+1;
%     end
% end
% %initialise starting value for each run of count 
% for i=1:n+1
%     l(i)=1;
% end
% %count each run of different massage
% j=1;
% i=1;
% while j<length(x)
%     if x(j)==x(j+1)
%         l(i)=l(i)+1;
%     else
%         b(i)=x(j);
%         i=i+1;
%     end
%     j=j+1;
% end
% b(n+1)=x(length(x));
% i=1;
% j=1;
% %storing run length encoded data to e
% while i<=length(l)&&j<=2*length(l)
%     e(j)=l(i);
%     e(j+1)=b(i);
%     i=i+1;
%     j=j+2;
% end
% %showing encoded data
% else
%     for p=1:c(1)
%         n=0;
%         for i=1:length(x(p,:))-1
%             if x(p,i)~=x(p,i+1);
%                 n=n+1;
%             end
%         end
%     end
% end
%  end


 
 
 
% function data = rle(x)
% % data = rle(x) (de)compresses the data with the RLE-Algorithm
% %   Compression:
% %      if x is a numbervector data{1} contains the values
% %      and data{2} contains the run lenths
% %
% %   Decompression:
% %      if x is a cell array, data contains the uncompressed values
% %
% %      Version 1.0 by Stefan Eireiner (<a href="mailto:stefan-e@web.de?subject=rle">stefan-e@web.de</a>)
% %      based on Code by Peter J. Acklam
% %      last change 14.05.2004
% if iscell(x) % decoding
% 	i = cumsum([ 1 x{2} ]);
% 	j = zeros(1, i(end)-1);
% 	j(i(1:end-1)) = 1;
% 	data = x{1}(cumsum(j));
% else % encoding
% 	if size(x,1) > size(x,2), x = x'; end % if x is a column vector, tronspose
%     i = [ find(x(1:end-1) ~= x(2:end)) length(x) ];
% 	data{2} = diff([ 0 i ]);
% 	data{1} = x(i);
% end