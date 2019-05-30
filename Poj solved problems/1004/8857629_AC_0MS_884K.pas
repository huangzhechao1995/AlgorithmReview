program poj1004;
 var i,j,n:longint;
 ans:double;
 a:array[1..20] of double;
begin
 for i:=1 to 12 do
  read(a[i]);
 for i:=1 to 12 do
  ans:=ans+a[i];
 ans:=ans/12;
 write('$');
 writeln(ans:0:2);
end.