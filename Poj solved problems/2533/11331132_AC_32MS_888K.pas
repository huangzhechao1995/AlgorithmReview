program poj2533;
 const maxn=1000;
 var i,j,n,m,p,q,l,r,k:longint;
 ans:longint;
 a:Array[1..maxn] of longint;
 f:array[0..maxn] of longint;
procedure openfile;
 begin
  assign(input,'poj.in');
  assign(output,'poj.out');
  reset(input);
  rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
begin
 readln(n);
 for i:=1 to n do
  begin
  read(a[i]);
  f[i]:=1;
  end;
 for i:=2 to n do
  for j:=i-1 downto 1 do
  if a[i]>a[j] then
   begin
   if f[j]+1>f[i] then f[i]:=f[j]+1;
   end;
 ans:=0;
 for i:=1 to n do
  if f[i]>ans then ans:=f[i];
 writeln(Ans);
end.