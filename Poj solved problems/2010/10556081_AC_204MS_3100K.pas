program finance;

 const maxn=100000+100; maxm=20000+10;
 type arr=record
  l{oan},s{core}:longint;
  end;
 var a:array[1..maxn] of arr;
  i,j,n,m,p,q,l,r,f:longint;
  heap:array[1..maxm] of longint;
  left,right:array[1..maxn] of int64;
  mm,tot:longint;
  ans,sum:int64;


procedure openfile;
 begin
 assign(input,'finance.in');
 assign(output,'finance.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; m,t:arr;
 begin
  i:=l; j:=r;
  m:=a[(l+r)div 2];
  repeat
   while a[i].s<m.s do inc(i);
   while a[j].s>m.s do dec(j);
   if i<=j then
    begin
    t:=a[i]; a[i]:=a[j]; a[j]:=t;
    inc(i); dec(j);
    end;
   until i>j;
  if l<j then qsort(l,j);
  if i<r then qsort(i,r);
 end;
procedure add(v:longint);
 var x,p,t:longint;
 begin
 inc(tot); heap[tot]:=v;
 x:=tot;
 while x>1 do
  begin
  p:=x div 2;
  if heap[x]>heap[p] then
   begin
    t:=heap[p]; heap[p]:=heap[x]; heap[x]:=t;
   end
  else break;
  x:=p;
  end;
 end;
procedure down;
 var x,p,k,t:longint;
 begin
  x:=1;
  while x*2<=tot do
   begin
   p:=x*2;
   if (x*2+1<=tot)and(heap[x*2+1]>heap[x*2]) then p:=x*2+1;
   if heap[p]>heap[x] then
    begin t:=heap[p]; heap[p]:=heap[x]; heap[x]:=t; end
   else break;
   x:=p;
   end;
 end;
begin
 //openfile;
 readln(m,n,f);
 for i:=1 to n do
  read(a[i].s,a[i].l);
 qsort(1,n);
 mm:=m div 2;
//--------------------------
 tot:=0; sum:=0;
 for i:=1 to mm do
  begin
  add(a[i].l);
  sum:=sum+int64(a[i].l);
  end;
 left[mm+1]:=sum;
 for i:=mm+2 to n-mm do
  begin
  if a[i-1].l<heap[1] then
   begin
   sum:=sum-heap[1]+a[i-1].l;
   heap[1]:=a[i-1].l;
   down;
   end;
  left[i]:=sum;
  end;
//--------------------------
 tot:=0; sum:=0;
 for i:=n downto n-mm+1 do
  begin
  add(a[i].l);
  sum:=sum+int64(a[i].l);
  end;
 right[n-mm]:=sum;
 for i:=n-mm-1 downto mm+1 do
  begin
  if a[i+1].l<heap[1] then
   begin
   sum:=sum-heap[1]+a[i+1].l;
   heap[1]:=a[i+1].l;
   down;
   end;
  right[i]:=sum;
  end;
 ans:=-1000;
 for i:=n-mm downto mm+1 do
  if left[i]+right[i]+a[i].l<=f then
   begin ans:=a[i].s; break; end;
 if ans=-1000 then writeln(-1) else writeln(ans);
// closefile;
end.