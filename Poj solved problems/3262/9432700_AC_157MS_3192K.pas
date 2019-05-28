program poj3262;
 type arr=record
  t,d:longint;
  p:double;
  end;
 const maxn=100000+100;
 var i,j,m,p,q,n,l,r,k:longint;
 a:array[1..maxn] of arr;
 s:array[0..maxn] of int64;
 ans:int64;
procedure openfile;
 begin
 assign(input,'poj3262.in');
 assign(output,'poj3262.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; m:double; t:arr;
 begin
 i:=l; j:=r;
 m:=a[(l+r) div 2].p;
 repeat
  while a[i].p>m do inc(i);
  while a[j].p<m do dec(j);
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
begin

 readln(n);
 for i:=1 to n do
  begin
  readln(a[i].t,a[i].d);
  a[i].p:=a[i].d/a[i].t;
  end;
 qsort(1,n);
 for i:=1 to n do
  s[i]:=s[i-1]+a[i].d;
 for i:=1 to n do
  begin
   ans:=(s[n]-s[i])*a[i].t*2+ans;
  end;
 writeln(ans);

end.
