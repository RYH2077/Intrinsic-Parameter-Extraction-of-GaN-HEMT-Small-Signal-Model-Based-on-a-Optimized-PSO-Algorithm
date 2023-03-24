% for n=1:4
%     Mod(n).x=[1+n 2;3 4];
% end
% z=Mod;
% for i=1:4
%     
% disp(z(i).x(1,1))
% end

A=[1 2 ; 4 5];
B=[1 2.01 ; 4 5];
C=mean(abs(A-B))