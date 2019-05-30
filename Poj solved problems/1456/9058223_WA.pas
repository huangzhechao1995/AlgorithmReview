program poj1456;
 type arr=record
  r,w:longint;
  end;
 const maxn=10000+500;
 var i,j,n,m,p,q,l,r,k:longint;
 a:array[1..maxn] of arr;
 father{,w}:array[0..maxn] of longint;
 dayline,ans:longint;
procedure openfile;
 begin
 assign(input,'poj1456.in');
 assign(output,'poj1456.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure qsort(l,r:longint);
 var i,j,m:longint; t:arr;
 begin
 i:=l; j:=r;
 m:=a[(l+r)div 2].w;
 repeat
  while a[i].w>m do inc(i);
  while a[j].w<m do dec(j);
  if i<=j then
   begin
   t:=a[i];
   a[i]:=a[j];
   a[j]:=t;
   inc(i);
   dec(j);
   end;
  until i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;
function getfather(x:longint):longint;
 begin
 if father[x]=x then exit(x);
 father[x]:=getfather(father[x]);
 exit(father[x]);
 end;
begin
 //openfile;
while not eof do
 begin
 read(n);
 if n<=0 then continue;
 dayline:=0;  ans:=0;
 for i:=1 to n do
  begin
  read(a[i].w,a[i].r);
  if a[i].r>dayline then dayline:=a[i].r;
  end;
 qsort(1,n);
 for i:=0 to dayline do
  father[i]:=i;
 for i:=1 to n do
  begin
  k:=a[i].r;
  p:=getfather(k);
  if p=0 then continue;
  inc(ans,a[i].w);
  father[k]:=k-1;
  end;
 writeln(ans);
 end;

// closefile;
end.