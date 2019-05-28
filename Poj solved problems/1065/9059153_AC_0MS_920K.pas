program poj1065;
 type arr=record
 l,w:longint;
 end;
 const maxn=5000+50;
 var i,j,n,m,p,q,l,r,k,w:longint;
 time,t,ans:longint;
 a:array[1..maxn] of arr;
 hash:array[1..maxn] of boolean;
function compare(a,b:arr):boolean;
 begin
 if a.l<b.l then exit(true);
 if a.l>b.l then exit(false);
 if a.w<b.w then exit(true);
 exit(false);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; t,m:arr;
 begin
 i:=l; j:=r;
 m:=a[(l+r)div 2];
 repeat
  while compare(a[i],m) do inc(i);
  while compare(m,a[j]) do dec(j);
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
procedure openfile;
 begin
 assign(input,'poj1065.in');
 assign(output,'poj1065.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
begin

 readln(time);
 for t:=1 to time do
  begin
  readln(n);
  for i:=1 to n do
  read(a[i].l,a[i].w);
  qsort(1,n);
  for i:=1 to n do
   hash[i]:=false;
  ans:=0;
  for i:=1 to n do
   if not hash[i] then
    begin
    l:=a[i].l; w:=a[i].w;
    for j:=i to n do
     if (l<=a[j].l)and(w<=a[j].w) then
     if not hash[j] then
      begin hash[j]:=true;  l:=a[j].l; w:=a[j].w; end;

    inc(ans);
    end;
  writeln(ans);
  end;


end.