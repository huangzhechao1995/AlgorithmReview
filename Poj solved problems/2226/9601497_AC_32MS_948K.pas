program cover;
 const maxn=50+5; maxm=50+5;
 type arr=record
       a,b,c:longint;
      end;
      tp=record
       l,r:longint;
       end;
 var i,j,n,m,p,q,l,r,k,tot,ans:longint;
 map:array[1..maxn,1..maxm] of arr;
 e:array[1..5000] of tp;
 pre,link:array[1..5000] of longint;
 visit:array[1..5000] of boolean;
 ch:char;
procedure openfile;
 begin
 assign(input,'poj2226.in');
 assign(output,'poj2226.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
function compare(a,b:tp):boolean;
 begin
 if a.l<b.l then exit(true);
 if a.l>b.l then exit(false);
 if a.r<b.r then exit(true);
 exit(false);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; t,m:tp;
 begin
 i:=l; j:=r; m:=e[(l+r) div 2];
 repeat
  while compare(e[i],m) do inc(i);
  while compare(m,e[j]) do dec(j);
  if i<=j then
   begin t:=e[i]; e[i]:=e[j]; e[j]:=t; inc(i); dec(j); end;
  until  i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;
procedure prepare;
 begin
 //------------make map---------------
 j:=1; p:=0;
 while j<=m do
  begin
  i:=1;
  while i<=n do
   begin
   while map[i,j].c=2 do inc(i);
   if i>n then break;
   inc(p);
   while map[i,j].c=1 do
    begin
    map[i,j].a:=p;
    inc(i);
    end;
   end;
  inc(j);
  end;
//------------make map---------------
 i:=1; q:=0;
 while i<=n do
  begin
  j:=1;
  while j<=m do
   begin
   while map[i,j].c=2 do inc(j);
   if j>m then break;
   inc(q);
   while map[i,j].c=1 do
    begin
    map[i,j].b:=p+q;
    inc(j);
    end;
   end;
  inc(i);
  end;
//------------------------------------
 tot:=0;
 for i:=1 to n do
  for j:=1 to m do
  if map[i,j].c=1 then
   begin
   l:=map[i,j].a; r:=map[i,j].b;
   inc(tot);
   e[tot].l:=l; e[tot].r:=r;
   inc(tot);
   e[tot].r:=l; e[tot].l:=r;
   end;
 qsort(1,tot);
 for i:=tot downto 1 do
  pre[e[i].l]:=i;
 pre[p+q+1]:=tot+1;
 for i:=p+q downto 1 do
  if pre[i]=0 then pre[i]:=pre[i+1];
 end;
function hungary(X:longint):boolean;
 var i,p:longint;
 begin
 for i:=pre[x] to pre[x+1]-1 do
  if not visit[e[i].r] then
  begin
  p:=e[i].r;
  visit[p]:=true;
  if (link[p]=0)  or hungary(link[p]) then
   begin
   link[p]:=x;
   exit(true);
   end;
  end;
  exit(false);
 end;
begin
//openfile;
//--------init--------------
 readln(n,m);
 for i:=1 to n do
  begin
  for j:=1 to m do
   begin
   read(ch);
   case ch of
    '*': map[i,j].c:=1;
    '.': map[i,j].c:=2;
    end;
   end;
  readln;
  end;
 prepare;
//------------Hungary------------------
 ans:=0;
 fillchar(link,sizeof(link),0);
 for i:=1 to p do
  begin
  fillchar(visit,sizeof(visit),false);
  if hungary(i) then inc(ans);
  end;
 writeln(ans);


// closefile;
end.
