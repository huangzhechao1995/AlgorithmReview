program poj3177;
 type arr=record
 l,r,num:longint;
 end;
const maxn=6000; maxm=30000;
var i,j,n,m,p,q,l,r,k:longint;
 e:array[1..30000] of arr;
 pre,low,dfn:array[-1..6000] of longint;
 hash:array[1..30000] of integer;
 color:array[1..30000] of longint;
 len:array[0..30000] of longint;
 ttt:arr;
 ans,sign,tbbt:longint;

procedure openfile;
 begin
 assign(input,'poj3177.in');
 assign(output,'poj3177.out');
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
function compare(a,b:arr):boolean;
 begin
 if a.l<b.l then exit(true);
 if a.l>b.l then exit(false);
 if a.r<b.r then exit(true);
 exit(false);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; t,m:arr;
 begin
 i:=l; j:=r;
 m:=e[(l+r) div 2];
 repeat
  while compare(e[i],m) do inc(i);
  while compare(m,e[j]) do dec(j);
  if i<=j then
   begin
   t:=e[i];
   e[i]:=e[j];
   e[j]:=t;
   inc(i);
   dec(j);
   end;
  until i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;
procedure dfs(x,k:longint);
 var i,j:longint; p:arr;
 begin
 for i:=pre[x] to pre[x+1]-1 do
  if (color[e[i].r]=0)and(dfn[e[i].r]>k) then
  begin
  color[e[i].r]:=ans;
  dfs(e[i].r,k);
  end;
 end;
procedure tarjan(x:longint);
 var i,j:longint; p:arr;
 begin
  inc(sign);  dfn[x]:=sign;
  low[x]:=sign;
  for i:=pre[x] to pre[x+1]-1 do
   if hash[e[i].num]=0 then
   begin
   p:=e[i];
   if dfn[p.r]=0 then
    begin
    hash[p.num]:=1;
    tarjan(p.r);
    if low[p.r]>dfn[x] then
     begin
     inc(ans); color[p.r]:=ans;
     dfs(p.r,dfn[x]);
     end;
    low[x]:=min(low[x],low[p.r]);
    end
   else
    begin
    hash[p.num]:=2;
    low[x]:=min(low[x],dfn[p.r]);
    end;
   end;
 end;
begin

//-------init---------------
// while not seekeof do
// begin
 fillchar(hash,sizeof(hash),0);
 fillchar(dfn,sizeof(dfn),0); fillchar(low,sizeof(low),0);
 fillchar(color,sizeof(color),0);
 readln(n,m);
 k:=0;
 for i:=1 to m do
  begin
  readln(l,r);
  inc(k); e[k].l:=l; e[k].r:=r; e[k].num:=i;
  inc(k); e[k].r:=l; e[k].l:=r; e[k].num:=i;
  end;
 qsort(1,2*m);
 if (e[1].l=1)and(e[1].r=3)and(e[2].r=5)and(e[3].r=6) then
  begin
  i:=1;
  end;
 i:=1;
 while i<=2*m do
  begin
  ttt:=e[i]; inc(i);
  while (e[i].l=ttt.l)and(e[i].r=ttt.r) do
   begin
   e[i].l:=-1; e[i].r:=-1;
   inc(i);
   end;
  end;
 for i:=2*m downto 1 do
  pre[e[i].l]:=i;
 pre[n+1]:=2*m+1;
 for i:=2*m downto 1 do
  if pre[i]=0 then pre[i]:=pre[i+1];
//--------------------------
 sign:=0;   ans:=0;
 tarjan(1);
 //writeln(ans);  {*}
// for i:=1 to n do
//  write(color[i],' ');
 for i:=1 to 2*m do
  if color[e[i].l]<>color[e[i].r] then
  begin
  inc(len[color[e[i].l]]);
  inc(len[color[e[i].r]]);
  end;
 tbbt:=0;
 for i:=0 to ans do
  if len[i]=2 then inc(tbbt);
 writeln((tbbt+1) div 2);
// end;

end.
