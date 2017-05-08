
function output_struct=conv()

%"Fulhack"
a=dir;
b=dir;

dos(['conv.exe &']);
while length(a)==length(b)
    pause(1);
    b=dir;
end

pause(3); %Wait 3 sec for conv to write the output file.
 
%find the name of the new file
b_name={b.name};
a_name={a.name};

k=0;
for i=1:1:length(a)
    k=strcmp(a_name(i),b_name)+k;
end

%Import the interesting data
output_struct=read_file_frz(b(~k).name);

end