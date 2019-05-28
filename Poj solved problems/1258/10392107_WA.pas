program poj1258;
 const maxn=100+5;
 type arr=record
  l,r,d:longint;
 end;
var i,j,n,m,p,q,l,r,k:longint;
 e:array[1..maxn*maxn] of arr;
 map:array[1..maxn,1..maxn] of longint;
 f:array[1..maxn] of longint;
 x,y,tot:longint; ans:int64;
procedure openfile;
 begin
 assign(input,'waff.in');
 assign(output,'waff.out');
 reset(input); rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure qsort(l,r:longint);
 var i,j,m:longint; t:arr;
 begin
 i:=l; j:=r; m:=e[(l+r) div 2].d;
 repeat
  while e[i].d<m do inc(i);
  while e[j].d>m do dec(j);
  if i<=j then
   begin
   t:=e[i]; e[i]:=e[j]; e[j]:=t;
   inc(i); dec(j);
   end;
  until i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;
function get(x:longint):longint;
 begin
 if x=f[x] then exit(x);
 f[x]:=get(f[x]);
 exit(f[x]);
 end;
begin
// openfile;
 while not seekeof do
  begin
  read(n);
  for i:=1 to n do
   begin
   for j:=1 to n do
    read(map[i,j]);
 //  readln;
   end;
  tot:=0;
  for i:=1 to n-1 do
   for j:=i+1 to n do
    begin
    inc(tot);
    e[tot].l:=i; e[tot].r:=j; e[tot].d:=map[i,j];
    end;
  qsort(1,tot);
  for i:=1 to n do
   f[i]:=i;
  j:=0; ans:=0;
  for i:=1 to tot do
   begin
   l:=get(e[i].l); r:=get(e[i].r);
   if l<>r then
    begin
    inc(j);
    f[j]:=i;
    ans:=ans+e[i].d;
    end;
   if j>=n then break;
   end;
  writeln(ans);
  end;

// closefile;
end.
