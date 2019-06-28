%file_selected = uigetfile({'*.mat'},'File selector');
load('ECG-10 Sec.mat');
subplot(5,1,1);
plot(val);

S = dct(val);
subplot(5,1,2);
plot(S);

%B =idct(S);
%subplot(5,1,3);
%plot(B);

   
% l=n(101:1000);
[S_sorted, k] = sort(abs(S)); %to get the smallest values to a specific threshold of elements number
M = 990;
u=S;
u(k(1:M)) = 0;
subplot(5,1,4);
plot(u);

compressedData = rle(u);
subplot(5,1,5);
plot(compressedData);

%cdfId = cdflib.create('u.cdf');
%Data_id = cdflib.createVar(cdfId,'Data','cdf_int4',1,[],true,[]);
%cdflib.putVarRecordData(cdfid,Data_id,0,u);
%cdflib.putVarRecordData(cdfid,Data_id,1,u);

%cdfid_open = cdflib.open('example.cdf');

%cdfwrite('u',u);
%cdflib.setCompression(cdfid, 'HUFF_COMPRESSION');
%cdflib.close(cdfId);

%h=idct(u);
%subplot(5,1,5);
%plot(h);
%save u_try.mat  u
