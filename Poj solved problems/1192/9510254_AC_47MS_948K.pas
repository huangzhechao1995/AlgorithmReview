program poj1192;
 const maxn=1000+50;
 type tp=record
  x,y,c:longint;
  end;
 var i,j,n,m,p,q,l,r,k:longint;
 a:array[1..maxn] of tp;
 f,father:array[1..maxn] of longint;
 e:array[1..maxn,1..10] of longint;
 len:array[1..maxn] of longint;
 ans:longint;
procedure openfile;
 begin
 assign(input,'poj1192.in');
 assign(output,'poj1192.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function max(a,b:longint):longint;
 begin
 if a>b then exit(a) else exit(b);
 end;
procedure treeDP(x:longint);
 var i,p:longint;
 begin
  for i:=1 to len[x] do
   if e[x,i]<>father[x] then
   begin
   father[e[x,i]]:=x;
   treeDP(e[x,i]);
   end;
  if (len[x]=1)and(father[x]<>-1) then
   begin f[x]:=max(a[x].c,0);if f[x]>ans then ans:=f[x]; exit; end;
  f[x]:=0;
  for i:=1 to len[x] do
   if e[x,i]<>father[x] then
   f[x]:=f[x]+max(f[e[x,i]],0);
  f[x]:=f[x]+a[x].c;
  if f[x]>ans then ans:=f[x];
 end;
begin
 //openfile;
 readln(n);
 for i:=1 to n do
  readln(a[i].x,a[i].y,a[i].c);
 for i:=1 to n-1 do
  for j:=i+1 to n do
  begin
  if abs(a[i].x-a[j].x)+abs(a[i].y-a[j].y)=1 then
   begin
   inc(len[i]); e[i,len[i]]:=j;
   inc(len[j]); e[j,len[j]]:=i;
   end;
  end;
 father[1]:=-1;
 treeDP(1);
 writeln(ans);
// closefile;
end.