program poj3180;
 const maxn=10000+100; maxm=50000+100;
 type arr=record
  l,r:longint;
  end;
 var i,j,n,m,p,q,l,r,k:longint;
 e:array[1..maxm] of arr;
 dfn,low,cl,pre:array[1..maxn] of longint;
 color,num,ans,time:longint;
procedure openfile;
 begin
 assign(input,'poj3180.in');
 assign(output,'poj3180.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
function min(a,b:longint):longint;
 begin
 if a<b then exit(a) else exit(b);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; t,m:arr;
 begin
  i:=l; j:=r; m:=e[(l+r) div 2];
  repeat
   while e[i].l<m.l do inc(i);
   while e[j].l>m.l do dec(j);
   if i<=j then
    begin
    t:=e[i]; e[i]:=e[j]; e[j]:=t; inc(i); dec(j);
    end;
   until i>j;
  if l<j then qsort(l,j);
  if i<r then qsort(i,r);
 end;
procedure dye(x:longint);
 var i:longint;
 begin
 inc(time); cl[x]:=color;
 for i:=pre[x] to pre[x+1]-1 do
  if cl[e[i].r]=0 then dye(e[i].r);
 end;
procedure tarjan(x:longint);
 var i,p:longint;
 begin
  inc(num); dfn[x]:=num; low[x]:=dfn[x];
  for i:=pre[x] to pre[x+1]-1 do
   if cl[e[i].r]=0 then
   begin
   p:=e[i].r;
   if dfn[p]=0 then
    begin
    tarjan(p);
    low[x]:=min(low[p],low[x]);
    end
   else low[x]:=min(low[x],dfn[p]);
   end;
  if low[x]=dfn[x] then
   begin
   inc(color); time:=0;
   dye(x);
   if time>=2 then inc(ans);
   end;
 end;
begin
// openfile;
 readln(n,m);
 for i:=1 to m do
  read(e[i].l,e[i].r);
 qsort(1,m);
 for i:=m downto 1 do
  pre[e[i].l]:=i;
 pre[n+1]:=m+1;
 for i:=n downto 1 do
  if pre[i]=0 then pre[i]:=pre[i+1];
//------------------------
 for i:=1 to n do
  if dfn[i]=0 then tarjan(i);
 writeln(ans);
// closefile;
end.