program poj3659;
 const maxn=10000+50;  maxv=50000000;
 type arr=record
  l,r:longint;
  end;
 var i,j,n,m,p,q,l,r,k:longint;
 e:array[1..maxn*2] of arr;
 pre:array[1..maxn] of longint;
 f:array[1..maxn,1..3] of longint;
 fa:array[1..maxn] of longint;
procedure openfile;
 begin
 assign(input,'poj3659.in');
 assign(output,'poj3659.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function compare(a,b:arr):boolean;
 begin
 if a.l<b.l then exit(true); if a.l>b.l then exit(false);
 if a.r<b.r then exit(true); exit(false);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; m,t:arr;
 begin
 i:=l; j:=r; m:=e[(l+r) div 2];
 repeat
  while compare(e[i],m) do inc(i);
  while compare(m,e[j]) do dec(j);
  if i<=j then
   begin
   t:=e[i]; e[i]:=e[j]; e[j]:=t;
   inc(i); dec(j);
   end;
  until i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;
procedure dye(x:longint);
 var i:longint;
 begin
 for i:=pre[x] to pre[x+1]-1 do
  if fa[e[i].r]=0 then
   begin
   fa[e[i].r]:=x; dye(e[i].r);
   end;
 end;
function min3(a,b,c:longint):longint;
 begin
 if (a<=b)and(a<=c) then exit(a);
 if (b<=c)and(b<=a) then exit(b);
 exit(c);
 end;
procedure treeDP(x:longint);
 var i,p:longint; flag:boolean; small:longint;
 begin
 for i:=pre[x] to pre[x+1]-1 do
  if e[i].r<>fa[x] then
   treeDP(e[i].r);
 if (pre[x+1]-1=pre[x])and(fa[x]<>-1) then
  begin
   f[x,1]:=1; f[x,2]:=maxv; f[x,3]:=0;
   exit;
  end;
 flag:=false;
 small:=maxv;
 for i:=pre[x] to pre[x+1]-1 do
  if e[i].r<>fa[x] then
  begin
  p:=e[i].r;
  f[x,1]:=f[x,1]+min3(f[p,1],f[p,2],f[p,3]);
  f[x,3]:=f[x,3]+f[p,2];
  if f[p,1]-f[p,2]<small then small:=f[p,1]-f[p,2];
  f[x,2]:=f[x,2]+min3(f[p,1],f[p,2],1000000000);
  end;
 if small>0 then f[x,2]:=f[x,2]+small;
 f[x,1]:=f[x,1]+1;
 end;
begin
 //openfile;
 readln(n);
 for i:=1 to n-1 do
  begin
  readln(e[i].l,e[i].r);
  e[i+n-1].l:=e[i].r; e[i+n-1].r:=e[i].l;
  end;
 m:=n*2-2;
 qsort(1,n*2-2);
 for i:=m downto 1 do
  pre[e[i].l]:=i;
 pre[n+1]:=m+1;
 for i:=n downto 1 do
  if pre[i]=0 then pre[i]:=pre[i+1];
 fa[1]:=-1;
 dye(1);
 treeDP(1);
 writeln(min3(f[1][1],f[1][2],100000000));
 //closefile;
end.