program poj3274;
 const maxn=100000+100;
 type
  arr=array[1..30] of longint;
  tp=record
  b:arr;
  num:longint;
  end;
 var i,j,n,m,p,q,l,r,k:longint;
 a:array[0..maxn] of tp;
 ans:longint;
procedure openfile;
 begin
 assign(input,'poj3274.in');
 assign(output,'poj3274.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure work(p:longint;var a:arr);
 var i,j,x:longint;
 begin
 x:=p;
 i:=0;
 while x>0 do
  begin x:=x shr 1; inc(i); end;
 x:=p;
 for j:=1 to i do
  begin
  a[j]:=x mod 2; x:=x shr 1;
  end;
 end;
function compare(p,q:tp):boolean;
 var i,j:longint;
 begin
  for i:=1 to k do
   begin
   if p.b[i]<q.b[i] then exit(true);
   if p.b[i]>q.b[i] then exit(false);
   end;
  if p.num<q.num then exit(true);
  exit(false);
 end;
function equal(p,q:tp):boolean;
 var i:longint;
 begin
 for i:=1 to k do
  if p.b[i]<>q.b[i] then exit(false);
 exit(true);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; m,t:tp;
 begin
 i:=l; j:=r; m:=a[(l+r) div 2];
 repeat
  while compare(a[i],m) do inc(i);
  while compare(m,a[j]) do dec(j);
  if i<=j then
   begin
   t:=a[i];
   a[i]:=a[j];
   a[j]:=t;
   inc(i); dec(j);
   end;
  until i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;
begin
 //openfile;
 readln(n,k);
 for i:=1 to n do
  begin
  a[i].num:=i;
  readln(p);
  work(p,a[i].b);
  end;
 for i:=1 to n do
  begin
  for j:=1 to k do
   a[i].b[j]:=a[i-1].b[j]+a[i].b[j];
  for j:=k downto 1 do
   a[i].b[j]:=a[i].b[j]-a[i].b[1];
  end;
 qsort(0,n);
 i:=0;
 a[n+1].b[1]:=100000;
 while i<=n do
  begin
  j:=i;
  while equal(a[j],a[j+1]) do
   inc(j);
  if a[j].num-a[i].num>ans then ans:=a[j].num-a[i].num;
  i:=j+1;
  end;
 writeln(Ans);
 //closefile;
end.
