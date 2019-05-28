program poj3250;
 const maxn=100000;
 var i,n,m,j,k,p,q:longint;
 h,r:array[1..maxn] of longint;
 ans:int64;
procedure openfile;
 begin
 assign(input,'poj3250.in');
 assign(output,'poj3250.out');
 reset(input); rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;

begin
// openfile;
 readln(n);
 for i:=1 to n do
  read(h[i]);
 h[n+1]:=maxlongint;
 for i:=1 to n+1 do
  r[i]:=i;
 for i:=n downto 1 do
  begin
  while h[r[r[i]]+1]<h[i] do
   r[i]:=r[r[i]]+1;
  while r[i]<>r[r[i]] do r[i]:=r[r[i]];
  end;
 for i:=1 to n do
  ans:=ans+r[i]-i;
 writeln(ans);
//closefile;
end.