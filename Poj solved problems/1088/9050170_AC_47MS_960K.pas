program tyvj1004;
const maxn=100;
var i,j,k,m,n,p,q,l,r:longint;  ans:longint;
 f:array[0..maxn+5,0..maxn+5] of longint;
 map:array[0..maxn+5,0..maxn+5] of longint;
 function max(a,b:longint):longint;
  begin
   if a>b then max:=a else max:=b;
  end;
 function search(i,j:longint):longint;
  begin
   if (i<=0)or(i>n) then exit(0);
   if (j<=0)or(j>m) then exit(0);
   if f[i,j]<>0 then exit(f[i,j]);
   f[i,j]:=1;
   if map[i+1,j]<map[i,j] then
    f[i,j]:=max(f[i,j],search(i+1,j)+1);
   if map[i-1,j]<map[i,j] then
    f[i,j]:=max(f[i,j],search(i-1,j)+1);
   if map[i,j+1]<map[i,j] then
    f[i,j]:=max(f[i,j],search(i,j+1)+1);
   if map[i,j-1]<map[i,j] then
    f[i,j]:=max(f[i,j],search(i,j-1)+1);
    exit(f[i,j]);
  end;
 begin
  read(n,m);
  for i:=0 to n+5 do
   for j:=0 to m+5 do
    map[i,j]:=maxlongint;
  for i:=1 to n do
   for j:=1 to m do
    read(map[i,j]);

  for i:=1 to n do
   for j:=1 to m do
    begin
    if f[i,j]=0 then
    f[i,j]:=search(i,j);
    if f[i,j]>ans then ans:=f[i,j];
    end;
  writeln(ans);
 end.