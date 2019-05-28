program poj2976;
 const maxn=1000+50;
 var i,j,n,m,p,q,k:longint;
 a,b:array[1..maxn] of longint;
 c:array[1..maxn] of double;
 ans,ans2,limit:double;
 ta,tb:int64;
procedure openfile;
 begin
 assign(input,'poj.in');
 assign(output,'poj.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure qsort(l,r:longint);
 var ta,tb,i,j:longint; m,t:double;
 begin
 i:=l; j:=r;
 m:=c[(l+r) div 2];
 repeat
  while c[i]>m do inc(i);
  while c[j]<m do dec(j);
  if i<=j then
   begin
   t:=c[i]; c[i]:=c[j]; c[j]:=t;
   ta:=a[i]; a[i]:=a[j]; a[j]:=ta;
   tb:=b[i]; b[i]:=b[j]; b[j]:=tb;
   inc(i); dec(j);
   end;
  until i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;
begin
 //openfile;
 read(n,k);
 limit:=1e-5;
while not (n=0) do
 begin
 k:=n-k;
 for i:=1 to n do
  read(a[i]);
 for i:=1 to n do
  read(b[i]);
 ans2:=0.5;
 repeat
   ans:=ans2;
   ta:=0; tb:=0;
   for i:=1 to n do c[i]:=a[i]-b[i]*ans;
   qsort(1,n);
   for i:=1 to k do
    begin
    inc(ta,a[i]); inc(tb,b[i]);
    end;
   ans2:=ta/tb;
  until abs(ans-ans2)<=limit;
 writeln(round(ans*100));
 read(n,k);
 end;
 //closefile;
end.