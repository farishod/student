global s1
s1=serial('COM4','BaudRate',2400);
%Varijabla s1 predstvalja serijski port COM2, odaberi prema svom ra�unaru
s1.InputBufferSize=1;
s1.Terminator='';
s1.Timeout=5;
fopen(s1)
%Serijski port COM2 je spreman za kori�tenje
%KRAJ!!!
