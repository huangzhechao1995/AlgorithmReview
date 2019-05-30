program dquery;
 const maxn=40000+100; maxm=40000+100;
 type link=^node;
  node=record
   r,d:longint;
   F:char;
   next:link;
  end;
 var i,j,n,m,l,r,k:longint;
  e:array[1..maxm] of link;
  p,q:link;
  dis,deep:array[1..maxn] of longint;
  fa:array[1..maxn] of longint;
  a:array[1..maxn*2] of longint;
  loc:array[1..maxn] of longint;
  f:array[1..maxn*2,0..15] of longint;
  dfn:longint;
  er:array[0..20] of longint;
  lca,ans:longint;
procedure openfile;
 begin
 assign(input,'dquery.in');
 assign(output,'dquery.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
procedure dfs(x:longint);
 var p:link; j:longint;
 begin
  p:=e[x];
  while p<>nil do
   begin
    j:=p^.r;
    if (dis[j]=0)and(j<>1) then
     begin
     fa[j]:=x;
     deep[j]:=deep[x]+1;
     dis[j]:=dis[x]+p^.d;
     dfs(j);
     end;
    p:=p^.next;
   end;
 end;
procedure dfs2(x:longint);
 var p:link; j:longint;
 begin
 inc(dfn); a[dfn]:=x;
 p:=e[x];
 while p<>nil do
  begin
  j:=p^.r;
  if fa[j]=x then
   begin
   dfs2(j);
   inc(dfn); a[dfn]:=x;
   end;
  p:=p^.next;
  end;
 end;
function min(a,b:longint):longint;
 begin
 if deep[a]<deep[b] then exit(a); exit(b);
 end;
procedure ST;
 var i,j,l,k,len:longint;
 begin
  er[0]:=1;
  for i:=1 to 20 do
   er[i]:=er[i-1]*2;
  for i:=1 to dfn do
   f[i,0]:=a[i];
  for len:=1 to trunc(ln(dfn)/ln(2)) do
   for i:=1 to dfn-er[len]+1 do
   begin
    l:=len-1;
    f[i,l+1]:=min(f[i,l],f[i+er[l],l]);
   end;
 end;
function query(l,r:longint):longint;
 var i,j,k:longint;
 begin
  k:=trunc(ln(r-l+1)/ln(2));
  query:=min(f[l,k],f[r-er[k]+1,k]);
  exit(query);
 end;
begin
 //openfile;
 readln(n,m);
 for i:=1 to m do e[i]:=nil;
 for i:=1 to m do
  begin
  readln(l,r,k);
  new(p); p^.r:=r; p^.d:=k; p^.next:=e[l]; e[l]:=p;
  new(p); p^.r:=l; p^.d:=k; p^.next:=e[r]; e[r]:=p;
  end;
 fillchar(dis,sizeof(dis),0);
 fillchar(deep,sizeof(deep),0);
 dfs(1);
 dfn:=0;
 dfs2(1);
 for i:=dfn downto 1 do
  loc[a[i]]:=i;
 ST;
 readln(k);
 for i:=1 to k do
  begin
   readln(l,r);
   lca:=query(loc[l],loc[r]);
   ans:=dis[l]+dis[r]-2*dis[lca];   writeln(ans);
  end;
 //closefile;
end.
