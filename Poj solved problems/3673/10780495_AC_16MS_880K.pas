program poj3673;
  var i,j,n,m,p,q:longint;
    s1,s2:string;
    a1,a2:array[1..15] of longint;
    ans:longint;
begin
 //assign(input,'poj.in');   reset(input);
 //assign(output,'poj.out'); rewrite(output);
  readln(s2);
  p:=pos(' ',s2);
  s1:=copy(s2,1,p-1); delete(s2,1,p);
  for i:=1 to length(s1) do
   a1[i]:=ord(s1[i])-ord('0');
  for i:=1 to length(s2) do
   a2[i]:=ord(s2[i])-ord('0');
  ans:=0;
  for i:=1 to length(s1) do
   for j:=1 to length(s2) do
    begin
    ans:=ans+a1[i]*a2[j];
    end;
  writeln(ans);

 //close(input); close(output);
end.
