clc
clear all

shalli  =   input('Run Secret Santa gift allocation system?(yes)','s');
diffnames = 1;
switch shalli
    
    case 'yes'
        
%   First read in secret santa names and email addresses

fid = fopen('secret_santa_list.txt','r');
% fid = fopen('secret_santa_test.txt');
n       =       0;

while feof(fid)==0
    
    n   =       n   +   1;
    
    d   =       textscan(fid,'%s\t%s\n');
    
    santa.names{n}      =       d{1};
    santa.emails{n}     =       d{2};
end
% carryon = input('Carry on?');
fclose(fid);

fid2 = fopen('email_login.txt','r');
login = textscan(fid2,'%s\t%s');

fclose(fid2);
myaddress = login{1};
mypassword = login{2};
disp(myaddress)
disp(mypassword)



while diffnames ~= 0

%   Generate 2 sets of random numbers

santa.nums1                 =       rand(length(santa.names),1);
santa.nums2                 =       rand(length(santa.names),1);

%   Order random numbers in increasing size, recording index

[i,santa.order1]      =       sort(santa.nums1);       
[j,santa.order2]      =       sort(santa.nums2);

%   Now reorder the names

santa.names1                =       santa.names(santa.order1);
santa.names2                =       santa.names(santa.order2);

%   Also want to reorder the emails with names1

santa.emails1               =       santa.emails(santa.order1);

%   Compare strings in first and second lists to check no one has
%   themselves

diffnames       =       0;

ranstring       =       'RANDOMIZING NAMES';

for n = 1:10
    clc
    disp(ranstring)
    ranstring       =       strcat(ranstring,'.');
    pause(0.1)
end

ranstring       =       'COMPILING REINDEER';

for n = 1:10
    clc
    disp(ranstring)
    ranstring       =       strcat(ranstring,'.');
    pause(0.1)
end

ranstring       =       'DEFRAGMENTING ELVES';

for n = 1:10
    clc
    disp(ranstring)
    ranstring       =       strcat(ranstring,'.');
    pause(0.1)
end

%%

for n = 1:length(santa.names)
    diffnames   =   diffnames + strcmp(santa.names1{n},santa.names2{n});
    
end

if diffnames == 0
       disp('SUCCESSFUL RANDOMIZED NAME MATRIX GENERTATION')
       
       save('SANTA_OUT.mat','santa');

% 
%        
% % Modify these two lines to reflect
% % your account and password.
% myaddress = 'mark.patton@nottingham.ac.uk';
% mypassword = 'xxxx';
% 
% setpref('Internet','E_mail',myaddress);
% setpref('Internet','SMTP_Server','smtp.nottingham.ac.uk');
% setpref('Internet','SMTP_Username','ad/ppzmjp1');
% setpref('Internet','SMTP_Password',mypassword);
% 
% props = java.lang.System.getProperties;
% props.setProperty('mail.smtp.auth','true');
% props.setProperty('mail.smtp.socketFactory.class', ...
%                   'javax.net.ssl.SSLSocketFactory');
% props.setProperty('mail.smtp.socketFactory.port','587');
% 

setpref('Internet','E_mail',myaddress);
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username',myaddress);
setpref('Internet','SMTP_Password',mypassword);

props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', ...
                  'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

for n = 1:length(santa.names)
     disp(['Sending e-mail to: ',santa.names1{n}])

line1       =       ['Dear ', char(santa.names1{:,n}), ','];
line2       =       ['Ho ho ho!  You''re buying a gift for ', char(santa.names2{:,n}),'.' ];
line3       =       'Lots of love,';
line4       =       'Santa x';
% line5       =       'Sent from MATLAB.  They said Mark couldn''t do it, but boy did he prove them wrong!';
% line6       =       'Who needs names in a hat when you have MATLAB!';

sendmail(santa.emails1{n}, 'Secret Santa Name',...
               [line1 10 10 line2 10 10 line3 10 line4]); %10 10 line5 10 line6]);
    disp('SENT! Merry Christmas')

end

disp('SECRET SANTA RANDOMIZATION AND NOTIFICATION ALGORITHM COMPLETE');
disp('MERRY CHRISTMAS!')
disp(' ')
% clear all
disp('MEMORY CLEARED')

else
       disp('FESTIVE KERNEL INITIALISATION FAILURE.  REINSERT ELVES AND RERUN...')
end
end
end
% santa


%% 


